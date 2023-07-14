#
# Created by GuHaijun on 2023/6/26.
#

LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

# LIBYUV_LIB_TYPE := STATIC
ifeq ($(LIBYUV_LIB_TYPE),)
    LIBYUV_LIB_TYPE := SHARED
endif

$(warning LIBYUV_LIB_TYPE: $(LIBYUV_LIB_TYPE))

LIBYUV_LOCAL_STATIC_LIBRARIES :=
LIBYUV_LOCAL_SHARED_LIBRARIES :=

LIBYUV_LOCAL_C_INCLUDES := \
	$(LOCAL_PATH)/include/libusb \

LIBYUV_LOCAL_EXPORT_C_INCLUDES := $(LIBYUV_LOCAL_C_INCLUDES)

LIBYUV_LIBS_DIR := lib/$(TARGET_ARCH_ABI)

ifeq ($(LIBYUV_LIB_TYPE), STATIC)
    LIBYUV_LIB_SUFFIX := .a
    
    include $(CLEAR_VARS)
    LOCAL_MODULE := yuv_static
    LOCAL_SRC_FILES := $(LIBYUV_LIBS_DIR)/lib$(LOCAL_MODULE)$(LIBYUV_LIB_SUFFIX)
    LOCAL_EXPORT_C_INCLUDES := $(LIBYUV_LOCAL_EXPORT_C_INCLUDES)
    ifeq ($(filter $(modules-get-list), $(LOCAL_MODULE)),)
        include $(PREBUILT_$(LIBYUV_LIB_TYPE)_LIBRARY)
    endif
    LIBYUV_LOCAL_$(LIBYUV_LIB_TYPE)_LIBRARIES += $(LOCAL_MODULE)
else 
    LIBYUV_LIB_SUFFIX := .so

    include $(CLEAR_VARS)
    LOCAL_MODULE := yuv
    LOCAL_SRC_FILES := $(LIBYUV_LIBS_DIR)/lib$(LOCAL_MODULE)$(LIBYUV_LIB_SUFFIX)
    LOCAL_EXPORT_C_INCLUDES := $(LIBYUV_LOCAL_EXPORT_C_INCLUDES)
    ifeq ($(filter $(modules-get-list), $(LOCAL_MODULE)),)
        include $(PREBUILT_$(LIBYUV_LIB_TYPE)_LIBRARY)
    endif
    LIBYUV_LOCAL_$(LIBYUV_LIB_TYPE)_LIBRARIES += $(LOCAL_MODULE)
endif
