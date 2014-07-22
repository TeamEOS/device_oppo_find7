LOCAL_PATH:= $(call my-dir)
ifneq ($(filter find7_caf find7a_caf,$(TARGET_DEVICE)),)
include $(CLEAR_VARS)

LOCAL_MODULE_TAGS := optional

LOCAL_SRC_FILES := $(call all-java-files-under, src)

LOCAL_PACKAGE_NAME := Find7Settings
LOCAL_CERTIFICATE := platform

include $(BUILD_PACKAGE)

# Use the following include to make our test apk.
include $(call all-makefiles-under,$(LOCAL_PATH)) 
endif
