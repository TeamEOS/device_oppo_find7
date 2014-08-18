/*
 * Copyright (C) 2008 The Android Open Source Project
 * Copyright (C) 2014 TeamEOS
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


// #define LOG_NDEBUG 0
#ifndef LOG_TAG
#define LOG_TAG "lights-hal"
#endif

#include <cutils/log.h>

#include <stdint.h>
#include <string.h>
#include <unistd.h>
#include <errno.h>
#include <fcntl.h>
#include <pthread.h>

#include <sys/ioctl.h>
#include <sys/types.h>

#include <hardware/lights.h>
#include <stdlib.h>
/******************************************************************************/

static pthread_once_t g_init = PTHREAD_ONCE_INIT;
static pthread_mutex_t g_lock = PTHREAD_MUTEX_INITIALIZER;
static struct light_state_t g_notification;
static struct light_state_t g_battery;
static int g_backlight = 255;
static int g_buttons = 0;
static int g_haveSkyline = 0;

char const*const RED_LED_FILE2
        = "sys/class/leds/rgb_red/brightness";
char const*const GREEN_LED_FILE2
        = "sys/class/leds/rgb_green/brightness";
char const*const BLUE_LED_FILE2
        = "sys/class/leds/rgb_blue/brightness";

char const*const RED_LED_FILE
        = "/sys/class/leds/red/brightness";
char const*const GREEN_LED_FILE
        = "/sys/class/leds/green/brightness";
char const*const BLUE_LED_FILE
        = "/sys/class/leds/blue/brightness";

char const*const LCD_FILE
        = "/sys/class/leds/lcd-backlight/brightness";
char const*const BUTTON_FILE
        = "/sys/class/leds/button-backlight/brightness";

char const*const RED_FREQ_FILE
        = "/sys/class/leds/red/device/grpfreq";
char const*const RED_PWM_FILE
        = "/sys/class/leds/red/device/grppwm";
char const*const RED_BLINK_FILE2
        = "/sys/class/leds/rgb_red/blink";
char const*const GREEN_BLINK_FILE2
        = "sys/class/leds/rgb_green/blink";
char const*const BLUE_BLINK_FILE2
        = "sys/class/leds/rgb_blue/blink";

char const*const RED_BLINK_FILE
        = "/sys/class/leds/red/device/blink";
char const*const GREEN_BLINK_FILE
        = "/sys/class/leds/green/blink";
char const*const BLUE_BLINK_FILE
        = "/sys/class/leds/blue/blink";
char const*const RED_RAMP_STEP_MS_FILE
        = "/sys/class/leds/rgb_red/ramp_step_ms";
char const*const BLUE_RAMP_STEP_MS_FILE
        = "/sys/class/leds/rgb_blue/ramp_step_ms";
char const*const GREEN_RAMP_STEP_MS_FILE
        = "/sys/class/leds/rgb_green/ramp_step_ms";
char *const PCBVERSION
        = "/sys/devices/system/soc/soc0/hw_pcb_version";

int battery_step = 20;
int notification_step = 30;

static int get_pcbversion() 
{
    int pcb_fd;
    int pcb_version = 0;
    char pcbver[8] = { '0' };
    pcb_fd = open(PCBVERSION, O_RDONLY);
    if(pcb_fd >= 0) 
    {
        read(pcb_fd, pcbver, 2);
        pcb_version = atoi(pcbver);
        close(pcb_fd);
    } 
    else 
    {
        printf("pcb_version error\n");
    }
    return pcb_version;
}
/**
 * device methods
 */

void init_globals(void)
{
    // init the mutex
    pthread_mutex_init(&g_lock, NULL);

    if(get_pcbversion()<20)  //find7
        g_haveSkyline = (access(BLUE_LED_FILE, W_OK) == 0) ? 1 : 0;

    else   //find7s
        g_haveSkyline = (access(BLUE_LED_FILE2, W_OK) == 0) ? 1 : 0;
}

static int
write_int(char const* path, int value)
{
    int fd;

    fd = open(path, O_RDWR);
    if (fd >= 0) {
        char buffer[20];
        int bytes = sprintf(buffer, "%d\n", value);
        int amt = write(fd, buffer, bytes);
        close(fd);
        return amt == -1 ? -errno : 0;
    } else {
        ALOGE("write_int failed to open %s\n", path);
        return -errno;
    }
}

static int
is_lit(struct light_state_t const* state)
{
    return state->color & 0x00ffffff;
}

static int
rgb_to_brightness(struct light_state_t const* state)
{
    int color = state->color & 0x00ffffff;
    return ((77*((color>>16)&0x00ff))
            + (150*((color>>8)&0x00ff)) + (29*(color&0x00ff))) >> 8;
}

static int
set_light_backlight(struct light_device_t* dev,
        struct light_state_t const* state)
{
    int err = 0;
    int brightness = rgb_to_brightness(state);
    pthread_mutex_lock(&g_lock);
    g_backlight = brightness;
    err = write_int(LCD_FILE, brightness);
    pthread_mutex_unlock(&g_lock);
    return err;
}
static int
set_light_buttons(struct light_device_t* dev,
        struct light_state_t const* state)
{
    int err = 0;
    int on = is_lit(state);
    pthread_mutex_lock(&g_lock);
    g_buttons = on;
    err = write_int(BUTTON_FILE, on?255:0);
    pthread_mutex_unlock(&g_lock);
    return err;
}

static int
set_speaker_light_locked(struct light_device_t* dev,
        struct light_state_t const* state)
{
    int len;
    int alpha, red, green, blue;
    int blink, freq, pwm;
    int onMS, offMS;
    unsigned int colorRGB;
    
    switch (state->flashMode) {
        case LIGHT_FLASH_TIMED:
            onMS = state->flashOnMS;
            offMS = state->flashOffMS;
            break;
        case LIGHT_FLASH_NONE:
        default:
            onMS = 0;
            offMS = 0;
            break;
    }

    colorRGB = state->color;

    red = (colorRGB >> 16) & 0xFF;
    green = (colorRGB >> 8) & 0xFF;
    blue = colorRGB & 0xFF;
    int lightSrcFlag;
    lightSrcFlag = (colorRGB >> 24) & 0xFF;
    if (g_haveSkyline) {
        if(get_pcbversion()<20)  //find7
        {
            write_int(RED_LED_FILE, red);
            write_int(GREEN_LED_FILE, green);
            write_int(BLUE_LED_FILE, blue);
        }
        else   //find7s
        {
            write_int(RED_LED_FILE2, red);
            write_int(GREEN_LED_FILE2, green);
            write_int(BLUE_LED_FILE2, blue);
        }
    } else {
        if (red) {
            if(get_pcbversion()<20)  //find7
            {
                write_int(GREEN_LED_FILE, 0);
            }
            else  //find7s
            {
                write_int(GREEN_LED_FILE2, 0);
            }
        } else if (green) {
            if(get_pcbversion()<20)  //find7
            {
                write_int(GREEN_LED_FILE, 1);
            }
            else  //find7s
            {
                write_int(GREEN_LED_FILE2, 1);
            } 
        } else {
            if(get_pcbversion()<20)  //find7
            {
                write_int(GREEN_LED_FILE, 0);
            }
            else  //find7s
            {
                write_int(GREEN_LED_FILE2, 0);
            }
        }
    }
    if (onMS > 0 && offMS > 0) {
        int totalMS = onMS + offMS;
        freq = totalMS / 50;
        pwm = (onMS * 255) / totalMS;
        if (pwm > 0 && pwm < 16)
            pwm = 16;
        blink = 1;
        battery_step = totalMS / 60;
        notification_step = totalMS / 60;
    } else {
        blink = 0;
        freq = 0;
        pwm = 0;
    }

#if 0
    ALOGD("%s, skyline=%i get_pcbversion=%i blink=%i colorRGB=%08X, onMS=%d, offMS=%d\n",
            __FUNCTION__, g_haveSkyline, get_pcbversion(), blink, colorRGB, onMS, offMS);
    ALOGD("%s, freq=%i pwm=%i battery_step=%i notification_step=%i\n",
            __FUNCTION__, freq, pwm, battery_step, notification_step);
#endif

    if (g_haveSkyline) {
        if (blink) {
            if(get_pcbversion() >= 20) //find7S
            {
                if(lightSrcFlag == 0xFE) //battery
                {
                    write_int(RED_RAMP_STEP_MS_FILE, battery_step);
                    write_int(BLUE_RAMP_STEP_MS_FILE, battery_step);
                    write_int(GREEN_RAMP_STEP_MS_FILE, battery_step);
                }
                else //notification
                {
                    write_int(RED_RAMP_STEP_MS_FILE, notification_step);
                    write_int(BLUE_RAMP_STEP_MS_FILE, notification_step);
                    write_int(GREEN_RAMP_STEP_MS_FILE, notification_step);
                }
                write_int(RED_BLINK_FILE2, blink);
                write_int(GREEN_BLINK_FILE2, blink);
                write_int(BLUE_BLINK_FILE2, blink);            
            } else {  //find7
                write_int(RED_PWM_FILE, pwm);
                write_int(RED_FREQ_FILE, freq);
            }
        }
        
        if(get_pcbversion() < 20) //find7
        {
            write_int(RED_BLINK_FILE, blink);
        }
    } else {
        ALOGE("%s, %s, No skyline  %i", __FUNCTION__, LOG_TAG, g_haveSkyline);
    }

    return 0;
}

static void
handle_speaker_battery_locked(struct light_device_t* dev)
{
    if (!is_lit(&g_notification)) {
        set_speaker_light_locked(dev, &g_battery);
    } else {
        set_speaker_light_locked(dev, &g_notification);
    }
}
static int
set_light_battery(struct light_device_t* dev,
        struct light_state_t const* state)
{
    pthread_mutex_lock(&g_lock);
    g_battery = *state;
    if (g_haveSkyline) {
        set_speaker_light_locked(dev, state);
    }
    handle_speaker_battery_locked(dev);
    pthread_mutex_unlock(&g_lock);
    return 0;
}

static int
set_light_notifications(struct light_device_t* dev,
        struct light_state_t const* state)
{
    pthread_mutex_lock(&g_lock);
    g_notification = *state;
    handle_speaker_battery_locked(dev);
    pthread_mutex_unlock(&g_lock);
    return 0;
}

/** Close the lights device */
static int
close_lights(struct light_device_t *dev)
{
    if (dev) {
        free(dev);
    }
    return 0;
}


/******************************************************************************/

/**
 * module methods
 */

/** Open a new instance of a lights device using name */
static int open_lights(const struct hw_module_t* module, char const* name,
        struct hw_device_t** device)
{
    int (*set_light)(struct light_device_t* dev,
            struct light_state_t const* state);

    if (0 == strcmp(LIGHT_ID_BACKLIGHT, name)) {
        set_light = set_light_backlight;
    }
    else if (0 == strcmp(LIGHT_ID_BUTTONS, name)) {
        set_light = set_light_buttons;
    }
    else if (0 == strcmp(LIGHT_ID_BATTERY, name)) {
        set_light = set_light_battery;
    }
    else if (0 == strcmp(LIGHT_ID_NOTIFICATIONS, name)) {
        set_light = set_light_notifications;
    }
    else {
        return -EINVAL;
    }

    pthread_once(&g_init, init_globals);

    struct light_device_t *dev = malloc(sizeof(struct light_device_t));
    memset(dev, 0, sizeof(*dev));

    dev->common.tag = HARDWARE_DEVICE_TAG;
    dev->common.version = 0;
    dev->common.module = (struct hw_module_t*)module;
    dev->common.close = (int (*)(struct hw_device_t*))close_lights;
    dev->set_light = set_light;

    *device = (struct hw_device_t*)dev;
    return 0;
}

static struct hw_module_methods_t lights_module_methods = {
    .open =  open_lights,
};

/*
 * The lights Module
 */
struct hw_module_t HAL_MODULE_INFO_SYM = {
    .tag = HARDWARE_MODULE_TAG,
    .version_major = 1,
    .version_minor = 0,
    .id = LIGHTS_HARDWARE_MODULE_ID,
    .name = "Find7 lights Module",
    .author = "TeamEOS",
    .methods = &lights_module_methods,
};
