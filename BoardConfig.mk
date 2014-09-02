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

# Define kernel config for inline building
TARGET_KERNEL_CONFIG := msm8974_find7wx_defconfig

# BT device name
BOARD_BLUETOOTH_BDROID_BUILDCFG_INCLUDE_DIR := device/oppo/find7/bluetooth

# TWRP specific build flags
DEVICE_RESOLUTION := 1080x1920

-include vendor/oppo/find7/BoardConfigVendor.mk
include device/oppo/find7/BoardConfigCommon.mk
