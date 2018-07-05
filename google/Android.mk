# -*- mode: makefile -*-
# Copyright (C) 2015 The Android Open Source Project
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

LOCAL_PATH := $(call my-dir)

cacerts_google := $(call all-files-under,files)

$(foreach cacert,$(cacerts_google),$(eval \
	$(call include-prebuilt-with-destination-directory,\
		target-cacert-google-$(notdir $(cacert)),\
		$(cacert),\
		$(TARGET_OUT)/etc/security/cacerts_google\
	)\
))

include $(CLEAR_VARS)
LOCAL_MODULE := cacerts_google
LOCAL_REQUIRED_MODULES := $(foreach cacert,$(cacerts_google),target-cacert-google-$(notdir $(cacert)))
include $(BUILD_PHONY_PACKAGE)

$(foreach cacert,$(cacerts_google),$(eval \
	$(call include-prebuilt-with-destination-directory,\
		host-cacert-google-$(notdir $(cacert)),\
		$(cacert),\
		$(HOST_OUT)/etc/security/cacerts_google\
	)\
))

include $(CLEAR_VARS)
LOCAL_MODULE := cacerts_google-host
LOCAL_IS_HOST_MODULE := true
LOCAL_REQUIRED_MODULES := $(foreach cacert,$(cacerts_google),host-cacert-google-$(notdir $(cacert)))
include $(BUILD_PHONY_PACKAGE)
