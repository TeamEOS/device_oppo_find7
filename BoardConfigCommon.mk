#
# Copyright (C) 2014 TeamEOS
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

BOARD_VENDOR := oppo

TARGET_GLOBAL_CFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_GLOBAL_CPPFLAGS += -mfpu=neon -mfloat-abi=softfp
TARGET_CPU_ABI := armeabi-v7a
TARGET_CPU_ABI2 := armeabi
TARGET_CPU_SMP := true
TARGET_ARCH := arm
TARGET_ARCH_VARIANT := armv7-a-neon
TARGET_CPU_VARIANT := krait
ARCH_ARM_HAVE_TLS_REGISTER := true

# Krait optimizations
TARGET_USE_KRAIT_BIONIC_OPTIMIZATION := true
TARGET_USE_KRAIT_PLD_SET := true
TARGET_KRAIT_BIONIC_PLDOFFS := 10
TARGET_KRAIT_BIONIC_PLDTHRESH := 10
TARGET_KRAIT_BIONIC_BBTHRESH := 64
TARGET_KRAIT_BIONIC_PLDSIZE := 64

TARGET_NO_BOOTLOADER := true

BOARD_KERNEL_BASE := 0x00000000
BOARD_KERNEL_PAGESIZE := 2048
BOARD_KERNEL_SEPARATED_DT := true

BOARD_KERNEL_CMDLINE := console=ttyHSL0,115200,n8 androidboot.hardware=find7 user_debug=31 msm_rtb.filter=0x37 ehci-hcd.park=3
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x02000000 --tags_offset 0x00000100

# Flags
COMMON_GLOBAL_CFLAGS += -DNO_SECURE_DISCARD

TARGET_SPECIFIC_HEADER_PATH := device/oppo/find7/include

# QC Time Services
BOARD_USES_QC_TIME_SERVICES := true
TARGET_NO_RPC := true

# Camera
COMMON_GLOBAL_CFLAGS += -DOPPO_CAMERA_HARDWARE -DFOURKSUPPORT
USE_DEVICE_SPECIFIC_CAMERA := true

# Lights
TARGET_PROVIDES_LIBLIGHT := true

# RIL
BOARD_RIL_CLASS := ../../../device/oppo/find7/ril/telephony/java/com/android/internal/telephony/QualcommMSIM42RIL.java

# Shader cache config options
# Maximum size of the GLES Shaders that can be cached for reuse.
# Increase the size if shaders of size greater than 12KB are used.
MAX_EGL_CACHE_KEY_SIZE := 12*1024

# Maximum GLES shader cache size for each app to store the compiled shader
# binaries. Decrease the size if RAM or Flash Storage size is a limitation
# of the device.
MAX_EGL_CACHE_SIZE := 2048*1024

# QC HAL selection
TARGET_QCOM_AUDIO_VARIANT := dummy
TARGET_QCOM_DISPLAY_VARIANT := dummy
TARGET_QCOM_MEDIA_VARIANT := dummy

# Audio
BOARD_USES_ALSA_AUDIO := true
AUDIO_FEATURE_DISABLED_DS1_DOLBY_DAP := true
AUDIO_FEATURE_DISABLED_DS1_DOLBY_DDP := true
AUDIO_FEATURE_DISABLED_FLUENCE := true
AUDIO_FEATURE_DISABLED_FM := true
AUDIO_FEATURE_DISABLED_INCALL_MUSIC := true
AUDIO_FEATURE_DISABLED_MULTI_VOICE_SESSIONS := true
AUDIO_FEATURE_DISABLED_OFFLOAD_PCM := true
AUDIO_FEATURE_DISABLED_PCM_24_BIT_OFFLOAD := true
AUDIO_FEATURE_DISABLED_SSR := true
AUDIO_FEATURE_DISABLED_COMPRESS_VOIP := true

# Display
TARGET_USES_C2D_COMPOSITION := true
TARGET_USES_ION := true
USE_OPENGL_RENDERER := true

# Bluetooth
BOARD_HAVE_BLUETOOTH := true
BOARD_HAVE_BLUETOOTH_QCOM := true
BLUETOOTH_HCI_USE_MCT := true

# Uses libqc-* static libraries from Qualcomm
BOARD_USES_LIBQC_OPT := true

# Boot animation
TARGET_BOOTANIMATION_PRELOAD := true
TARGET_BOOTANIMATION_TEXTURE_CACHE := true
TARGET_BOOTANIMATION_USE_RGB565 := true

# Wifi
BOARD_HAS_QCOM_WLAN              := true
BOARD_WLAN_DEVICE                := qcwcn
WPA_SUPPLICANT_VERSION           := VER_0_8_X
BOARD_WPA_SUPPLICANT_DRIVER      := NL80211
BOARD_WPA_SUPPLICANT_PRIVATE_LIB := lib_driver_cmd_qcwcn
BOARD_HOSTAPD_DRIVER             := NL80211
BOARD_HOSTAPD_PRIVATE_LIB        := lib_driver_cmd_qcwcn
WIFI_DRIVER_FW_PATH_STA          := "sta"
WIFI_DRIVER_FW_PATH_AP           := "ap"

TARGET_BOARD_PLATFORM := msm8974
TARGET_BOOTLOADER_BOARD_NAME := find7
TARGET_BOARD_INFO_FILE := device/oppo/find7/board-info.txt

BOARD_EGL_CFG := device/oppo/find7/egl.cfg

# For ext4 partitions larger than 2gb
BOARD_HAS_LARGE_FILESYSTEM := true

TARGET_USERIMAGES_USE_EXT4 := true
BOARD_BOOTIMAGE_PARTITION_SIZE     := 16777216
#BOARD_RECOVERYIMAGE_PARTITION_SIZE := 16777216 HACK: increase size to allow build
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 17777216
BOARD_SYSTEMIMAGE_PARTITION_SIZE   := 1073741824
BOARD_USERDATAIMAGE_PARTITION_SIZE := 13747929088 # 13747945472 - 16384 for crypto footer
BOARD_CACHEIMAGE_PARTITION_SIZE    := 536870912
BOARD_CACHEIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_PERSISTIMAGE_PARTITION_SIZE  := 33554432
#BOARD_PERSISTIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_FLASH_BLOCK_SIZE := 131072

TARGET_RELEASETOOLS_EXTENSIONS := device/oppo/find7
TARGET_OTA_ASSERT_DEVICE := find7,find7a,Find7,Find7a,FIND7,X9006,X9007

#BOARD_HAL_STATIC_LIBRARIES := libdumpstate.find7

BOARD_SEPOLICY_DIRS += \
       device/oppo/find7/sepolicy

BOARD_CUSTOM_BOOTIMG_MK := device/oppo/find7/mkbootimg.mk

# Define kernel source for inline building
TARGET_KERNEL_SOURCE := kernel/oppo/msm8974

# The list below is order dependent
BOARD_SEPOLICY_UNION += \
    file.te \
    device.te \
    app.te \
    cne.te \
    qmux.te \
    mpdecision.te \
    thermald.te \
    ueventd.te \
    vold.te \
    zygote.te \
    system.te \
    file_contexts \
    genfs_contexts \
    te_macros

HAVE_ADRENO_SOURCE:= false

OVERRIDE_RS_DRIVER:= libRSDriver_adreno.so
TARGET_FORCE_HWC_FOR_VIRTUAL_DISPLAYS := true

TARGET_TOUCHBOOST_FREQUENCY := 1200

# Recovery
TARGET_RECOVERY_FSTAB := device/oppo/find7/ramdisk/fstab.find7

# TWRP specific build flags
RECOVERY_GRAPHICS_USE_LINELENGTH := true
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
BOARD_USE_CUSTOM_RECOVERY_FONT := \"roboto_23x41.h\"
TW_NO_USB_STORAGE := true
TW_INCLUDE_JB_CRYPTO := true
BOARD_SUPPRESS_SECURE_ERASE := true

-include vendor/oppo/find7/BoardConfigVendor.mk
