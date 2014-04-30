#
# Copyright (C) 2013 The Android Open-Source Project
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

# OPPO ramfs bits
PRODUCT_COPY_FILES += \
    device/oppo/find7/ramdisk/init.find7.usb.rc:root/init.find7.usb.rc

# QCOM ramfs bits
PRODUCT_COPY_FILES += \
    device/oppo/find7/ramdisk/init.find7.rc:root/init.find7.rc \
    device/oppo/find7/ramdisk/fstab.find7:root/fstab.find7 \
    device/oppo/find7/ramdisk/ueventd.find7.rc:root/ueventd.find7.rc

# TWRP fstab
PRODUCT_COPY_FILES += \
    device/oppo/find7/twrp.fstab:recovery/root/etc/twrp.fstab

# QCOM scripts
PRODUCT_COPY_FILES += \
    device/oppo/find7/qcscripts/init.qcom.bt.sh:system/etc/init.qcom.bt.sh

# Input device files for find7
PRODUCT_COPY_FILES += \
    device/oppo/find7/input/gpio-keys.kl:system/usr/keylayout/gpio-keys.kl \
    device/oppo/find7/input/atmel_mxt_ts.kl:system/usr/keylayout/atmel_mxt_ts.kl
    
# QC IPC cfg
PRODUCT_COPY_FILES += \
    device/oppo/find7/configs/sec_config:system/etc/sec_config

# QC sensor cfg
PRODUCT_COPY_FILES += \
    device/oppo/find7/configs/sensor_def_qcomdev.conf:system/etc/sensor_def_qcomdev.conf

# ACDB Loader calibration
PRODUCT_COPY_FILES += \
	device/oppo/find7/acdb/MTP_Bluetooth_cal.acdb:system/etc/acdbdata/MTP/MTP_Bluetooth_cal.acdb \
	device/oppo/find7/acdb/MTP_General_cal.acdb:system/etc/acdbdata/MTP/MTP_General_cal.acdb \
	device/oppo/find7/acdb/MTP_Global_cal.acdb:system/etc/acdbdata/MTP/MTP_Global_cal.acdb \
	device/oppo/find7/acdb/MTP_Handset_cal.acdb:system/etc/acdbdata/MTP/MTP_Handset_cal.acdb \
	device/oppo/find7/acdb/MTP_Hdmi_cal.acdb:system/etc/acdbdata/MTP/MTP_Hdmi_cal.acdb \
	device/oppo/find7/acdb/MTP_Headset_cal.acdb:system/etc/acdbdata/MTP/MTP_Headset_cal.acdb \
	device/oppo/find7/acdb/MTP_Speaker_cal.acdb:system/etc/acdbdata/MTP/MTP_Speaker_cal.acdb \

# Audio policy
PRODUCT_COPY_FILES += \
    device/oppo/find7/audio_policy.conf:system/etc/audio_policy.conf

# Sound config for TAIKO
PRODUCT_COPY_FILES += \
    device/oppo/find7/snd_soc_msm/snd_soc_apq_Taiko_DB:system/etc/snd_soc_msm/snd_soc_apq_Taiko_DB \
    device/oppo/find7/snd_soc_msm/snd_soc_msm_Taiko:system/etc/snd_soc_msm/snd_soc_msm_Taiko \
    device/oppo/find7/snd_soc_msm/snd_soc_msm_Taiko_CDP:system/etc/snd_soc_msm/snd_soc_msm_Taiko_CDP \
    device/oppo/find7/snd_soc_msm/snd_soc_msm_Taiko_ES325:system/etc/snd_soc_msm/snd_soc_msm_Taiko_ES325 \
    device/oppo/find7/snd_soc_msm/snd_soc_msm_Taiko_Fluid:system/etc/snd_soc_msm/snd_soc_msm_Taiko_Fluid \
    device/oppo/find7/snd_soc_msm/snd_soc_msm_Taiko_liquid:system/etc/snd_soc_msm/snd_soc_msm_Taiko_liquid \
    device/oppo/find7/snd_soc_msm/snd_soc_msm_Taiko_OnePlus:system/etc/snd_soc_msm/snd_soc_msm_Taiko_OnePlus

# Media configuration
PRODUCT_COPY_FILES += \
    frameworks/av/media/libstagefright/data/media_codecs_google_audio.xml:system/etc/media_codecs_google_audio.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_telephony.xml:system/etc/media_codecs_google_telephony.xml \
    frameworks/av/media/libstagefright/data/media_codecs_google_video.xml:system/etc/media_codecs_google_video.xml \
    device/oppo/find7/media_codecs.xml:system/etc/media_codecs.xml \
    device/oppo/find7/media_profiles.xml:system/etc/media_profiles.xml \
    device/oppo/find7/mixer_paths.xml:system/etc/mixer_paths.xml

# These are the hardware-specific features
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/handheld_core_hardware.xml:system/etc/permissions/handheld_core_hardware.xml \
    frameworks/native/data/etc/android.hardware.camera.flash-autofocus.xml:system/etc/permissions/android.hardware.camera.flash-autofocus.xml \
    frameworks/native/data/etc/android.hardware.camera.front.xml:system/etc/permissions/android.hardware.camera.front.xml \
    frameworks/native/data/etc/android.hardware.location.gps.xml:system/etc/permissions/android.hardware.location.gps.xml \
    frameworks/native/data/etc/android.hardware.wifi.xml:system/etc/permissions/android.hardware.wifi.xml \
    frameworks/native/data/etc/android.hardware.wifi.direct.xml:system/etc/permissions/android.hardware.wifi.direct.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.barometer.xml:system/etc/permissions/android.hardware.sensor.barometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepcounter.xml:system/etc/permissions/android.hardware.sensor.stepcounter.xml \
    frameworks/native/data/etc/android.hardware.sensor.stepdetector.xml:system/etc/permissions/android.hardware.sensor.stepdetector.xml \
    frameworks/native/data/etc/android.hardware.touchscreen.multitouch.jazzhand.xml:system/etc/permissions/android.hardware.touchscreen.multitouch.jazzhand.xml \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml \
    frameworks/native/data/etc/android.hardware.usb.accessory.xml:system/etc/permissions/android.hardware.usb.accessory.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.audio.low_latency.xml:system/etc/permissions/android.hardware.audio.low_latency.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.telephony.cdma.xml:system/etc/permissions/android.hardware.telephony.cdma.xml

# NFC access control + feature files
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.nfc.xml:system/etc/permissions/android.hardware.nfc.xml

PRODUCT_COPY_FILES += \
    device/oppo/find7/configs/thermald-8974.conf:system/etc/thermald-8974.conf \
    device/oppo/find7/configs/thermal-engine-8974.conf:system/etc/thermal-engine-8974.conf

PRODUCT_TAGS += dalvik.gc.type-precise

# This device is xhdpi.  However the platform doesn't
# currently contain all of the bitmaps at xhdpi density so
# we do this little trick to fall back to the hdpi version
# if the xhdpi doesn't exist.
PRODUCT_AAPT_CONFIG := normal hdpi xhdpi xxhdpi
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

DEVICE_PACKAGE_OVERLAYS := \
    device/oppo/find7/overlay

PRODUCT_PACKAGES += \
    Torch

# WiFi
PRODUCT_COPY_FILES += \
    device/oppo/find7/wifi/WCNSS_cfg.dat:system/etc/firmware/wlan/prima/WCNSS_cfg.dat \
    device/oppo/find7/wifi/WCNSS_qcom_cfg.ini:system/etc/firmware/wlan/prima/WCNSS_qcom_cfg.ini \
    device/oppo/find7/wifi/WCNSS_qcom_wlan_nv.bin:system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin \
    device/oppo/find7/wifi/wpa_supplicant_overlay.conf:system/etc/wifi/wpa_supplicant_overlay.conf \
    device/oppo/find7/wifi/p2p_supplicant_overlay.conf:system/etc/wifi/p2p_supplicant_overlay.conf

PRODUCT_PACKAGES += \
    mac-update \
    wcnss_service

PRODUCT_PACKAGES += \
    hostapd_default.conf \
    hostapd.accept \
    hostapd.deny \
    libwpa_client \
    hostapd \
    wpa_supplicant \
    wpa_supplicant.conf

# Live Wallpapers
PRODUCT_PACKAGES += \
    LiveWallpapersPicker \
    librs_jni

# Local wrapper for fixups
PRODUCT_PACKAGES += \
	camera.find7

# Display
PRODUCT_PACKAGES += \
    copybit.msm8974 \
    gralloc.msm8974 \
    hwcomposer.msm8974 \
    memtrack.msm8974 \
    liboverlay

# OMX
PRODUCT_PACKAGES += \
    libc2dcolorconvert \
    libdivxdrmdecrypt \
    libstagefrighthw \
    libOmxAacEnc \
    libOmxAmrEnc \
    libOmxEvrcEnc \
    libOmxQcelp13Enc \
    libOmxCore \
    libmm-omxcore \
    libOmxVdec \
    libOmxVdecHevc \
    libOmxVenc

# Audio
PRODUCT_PACKAGES += \
    audio.primary.msm8974 \
    audio.a2dp.default \
    audio.usb.default \
    audio.r_submix.default \
    libaudio-resampler

# Audio effects
PRODUCT_PACKAGES += \
    libdirac \
    libqcomvisualizer \
    libqcomvoiceprocessing \
    libqcomvoiceprocessingdescriptors \
    libqcompostprocbundle

PRODUCT_PACKAGES += \
    libqomx_core \

PRODUCT_PACKAGES += \
    keystore.msm8974

PRODUCT_PACKAGES += \
    power.msm8974 \
    power.find7

# GPS configuration
PRODUCT_COPY_FILES += \
    device/oppo/find7/gps/gps.conf:system/etc/gps.conf \
    device/oppo/find7/gps/izat.conf:system/etc/izat.conf \
    device/oppo/find7/gps/sap.conf:system/etc/sap.conf

# NFC packages
PRODUCT_PACKAGES += \
    libnfc \
    libnfc_jni \
    Nfc \
    Tag

PRODUCT_PACKAGES += \
    libion

PRODUCT_PACKAGES += \
    lights.msm8974

PRODUCT_PACKAGES += \
    com.android.future.usb.accessory

# Filesystem management tools
PRODUCT_PACKAGES += \
    e2fsck

# Offline charging mode
PRODUCT_PACKAGES += \
    charger \
    charger_res_images

# Device Settings
PRODUCT_PACKAGES += \
    Find7Settings

# msm_rng entropy feeder
PRODUCT_PACKAGES += \
    qrngd \
    qrngp

PRODUCT_PROPERTY_OVERRIDES += \
    ro.opengles.version=196608

PRODUCT_PROPERTY_OVERRIDES += \
    persist.hwc.mdpcomp.enable=true

PRODUCT_PROPERTY_OVERRIDES += \
    drm.service.enabled=true

# Ril sends only one RIL_UNSOL_CALL_RING, so set call_ring.multiple to false
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.call_ring.multiple=0

PRODUCT_PROPERTY_OVERRIDES += \
    wifi.interface=wlan0 \
    wifi.supplicant_scan_interval=15

# Enable AAC 5.1 output
PRODUCT_PROPERTY_OVERRIDES += \
    media.aac_51_output_enabled=true

# Audio Configuration
PRODUCT_PROPERTY_OVERRIDES += \
    persist.audio.handset.mic.type=digital \
    persist.audio.dualmic.config=endfire \
    persist.audio.fluence.voicecall=true \
    persist.audio.fluence.voicerec=false \
    persist.audio.fluence.speaker=false

# Sensor Configuration
PRODUCT_PROPERTY_OVERRIDES += \
    ro.qc.sdk.sensors.gestures=true

# GPS Configuration
PRODUCT_PROPERTY_OVERRIDES += \
    ro.qc.sdk.izat.premium_enabled=1 \
    ro.qc.sdk.izat.service_mask=0x5 \
    persist.gps.qc_nlp_in_use=0 \
    ro.gps.agps_provider=1

# Networks
PRODUCT_PROPERTY_OVERRIDES += \
    ro.telephony.ril_class=QualcommMSIM42RIL

# LTE
PRODUCT_PROPERTY_OVERRIDES += \
    telephony.lteOnGsmDevice=1 \
    telephony.lteOnCdmaDevice=0 \
    ro.telephony.default_network=9

# Qcom time daemon
PRODUCT_PROPERTY_OVERRIDES += \
    persist.timed.enable=true

# NFC DT
PRODUCT_PROPERTY_OVERRIDES += \
    ro.nfc.port=I2C

# WiFi display
PRODUCT_PROPERTY_OVERRIDES += \
    persist.debug.wfd.enable=1 \
    persist.sys.wfd.virtual=0

# set default USB configuration
PRODUCT_DEFAULT_PROPERTY_OVERRIDES += \
    persist.sys.usb.config=mtp

# Platform
PRODUCT_PROPERTY_OVERRIDES += \
    ro.board.platform=msm8974

# Serial
PRODUCT_PROPERTY_OVERRIDES += \
    ro.serialno=530ef047

# Allow device to be used without SIM
PRODUCT_PROPERTY_OVERRIDES += \
    keyguard.no_require_sim=true

# DRM content
PRODUCT_PROPERTY_OVERRIDES += \
    drm.service.enabled=true

# Qcom optimizations
PRODUCT_PROPERTY_OVERRIDES += \
    ro.vendor.extension_library=/vendor/lib/libqc-opt.so

# RIL props
PRODUCT_PROPERTY_OVERRIDES += \
    rild.libpath=/vendor/lib/libril-qc-qmi-1.so \
    ril.subscription.types=NV,RUIM

# DiracHD audio effects
PRODUCT_PROPERTY_OVERRIDES += \
    dsp.dirac.enable=true

# Chromecast support
PRODUCT_PROPERTY_OVERRIDES += \
    ro.enable.chromecast.mirror=true

# setup dalvik vm configs.
$(call inherit-product, frameworks/native/build/phone-xhdpi-2048-dalvik-heap.mk)
