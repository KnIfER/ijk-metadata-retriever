#
# Copyright (c) 2013 Bilibili
# Copyright (c) 2013 Zhang Rui <bbcallen@gmail.com>
#
# This file is part of ijkPlayer.
#
# ijkPlayer is free software; you can redistribute it and/or
# modify it under the terms of the GNU Lesser General Public
# License as published by the Free Software Foundation; either
# version 2.1 of the License, or (at your option) any later version.
#
# ijkPlayer is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# Lesser General Public License for more details.
#
# You should have received a copy of the GNU Lesser General Public
# License along with ijkPlayer; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
# -mfloat-abi=soft is a workaround for FP register corruption on Exynos 4210
# http://www.spinics.net/lists/arm-kernel/msg368417.html
ifeq ($(TARGET_ARCH_ABI),armeabi-v7a)
LOCAL_CFLAGS += -mfloat-abi=soft -D__STDC_CONSTANT_MACROS
endif
LOCAL_CFLAGS += -std=c99
LOCAL_LDLIBS += -llog -landroid

LOCAL_C_INCLUDES += $(LOCAL_PATH)
LOCAL_C_INCLUDES += $(realpath $(LOCAL_PATH)/..)
LOCAL_C_INCLUDES += $(MY_APP_FFMPEG_INCLUDE_PATH)
LOCAL_C_INCLUDES += $(realpath $(LOCAL_PATH)/../ijkj4a)

LOCAL_SRC_FILES += mediametadataretriever.cpp
LOCAL_SRC_FILES += wseemann_media_MediaMetadataRetriever.cpp
LOCAL_SRC_FILES += ffmpeg_mediametadataretriever.c
LOCAL_SRC_FILES += ffmpeg_utils.c

LOCAL_SHARED_LIBRARIES := ijkffmpeg ijksdl
LOCAL_STATIC_LIBRARIES := android-ndk-profiler ijksoundtouch

LOCAL_MODULE := ffmpeg_metadata_jni

VERSION_SH  = $(LOCAL_PATH)/version.sh
VERSION_H   = ijkversion.h
$(info $(shell ($(VERSION_SH) $(LOCAL_PATH) $(VERSION_H))))
include $(BUILD_SHARED_LIBRARY)