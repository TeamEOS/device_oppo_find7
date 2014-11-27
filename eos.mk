$(call inherit-product, device/oppo/find7/full_find7.mk)

# Enhanced NFC
$(call inherit-product, vendor/eos/config/nfc_enhanced.mk)

# Inherit some common Eos stuff.
$(call inherit-product, vendor/eos/config/common_full_phone.mk)

# Copy Bootanimation
PRODUCT_COPY_FILES += \
vendor/eos/prebuilt/common/bootanimation/1080.zip:system/media/bootanimation.zip

PRODUCT_NAME := eos_find7
