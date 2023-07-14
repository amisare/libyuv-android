#
# Created by GuHaijun on 2023/7/13.
#

LOCAL_PATH:= $(call my-dir)
LIBYUV_ROOT_REL := ../../libyuv
LIBYUV_ROOT_ABS := $(LOCAL_PATH)/../../libyuv

include $(CLEAR_VARS)

LOCAL_CPP_EXTENSION := .cc

LOCAL_SRC_FILES := \
    $(LIBYUV_ROOT_REL)/source/compare.cc           \
    $(LIBYUV_ROOT_REL)/source/compare_common.cc    \
    $(LIBYUV_ROOT_REL)/source/compare_gcc.cc       \
    $(LIBYUV_ROOT_REL)/source/compare_mmi.cc       \
    $(LIBYUV_ROOT_REL)/source/compare_msa.cc       \
    $(LIBYUV_ROOT_REL)/source/compare_neon.cc      \
    $(LIBYUV_ROOT_REL)/source/compare_neon64.cc    \
    $(LIBYUV_ROOT_REL)/source/compare_win.cc       \
    $(LIBYUV_ROOT_REL)/source/convert.cc           \
    $(LIBYUV_ROOT_REL)/source/convert_argb.cc      \
    $(LIBYUV_ROOT_REL)/source/convert_from.cc      \
    $(LIBYUV_ROOT_REL)/source/convert_from_argb.cc \
    $(LIBYUV_ROOT_REL)/source/convert_to_argb.cc   \
    $(LIBYUV_ROOT_REL)/source/convert_to_i420.cc   \
    $(LIBYUV_ROOT_REL)/source/cpu_id.cc            \
    $(LIBYUV_ROOT_REL)/source/planar_functions.cc  \
    $(LIBYUV_ROOT_REL)/source/rotate.cc            \
    $(LIBYUV_ROOT_REL)/source/rotate_any.cc        \
    $(LIBYUV_ROOT_REL)/source/rotate_argb.cc       \
    $(LIBYUV_ROOT_REL)/source/rotate_common.cc     \
    $(LIBYUV_ROOT_REL)/source/rotate_gcc.cc        \
    $(LIBYUV_ROOT_REL)/source/rotate_mmi.cc        \
    $(LIBYUV_ROOT_REL)/source/rotate_msa.cc        \
    $(LIBYUV_ROOT_REL)/source/rotate_neon.cc       \
    $(LIBYUV_ROOT_REL)/source/rotate_neon64.cc     \
    $(LIBYUV_ROOT_REL)/source/rotate_win.cc        \
    $(LIBYUV_ROOT_REL)/source/row_any.cc           \
    $(LIBYUV_ROOT_REL)/source/row_common.cc        \
    $(LIBYUV_ROOT_REL)/source/row_gcc.cc           \
    $(LIBYUV_ROOT_REL)/source/row_mmi.cc           \
    $(LIBYUV_ROOT_REL)/source/row_msa.cc           \
    $(LIBYUV_ROOT_REL)/source/row_neon.cc          \
    $(LIBYUV_ROOT_REL)/source/row_neon64.cc        \
    $(LIBYUV_ROOT_REL)/source/row_win.cc           \
    $(LIBYUV_ROOT_REL)/source/scale.cc             \
    $(LIBYUV_ROOT_REL)/source/scale_any.cc         \
    $(LIBYUV_ROOT_REL)/source/scale_argb.cc        \
    $(LIBYUV_ROOT_REL)/source/scale_common.cc      \
    $(LIBYUV_ROOT_REL)/source/scale_gcc.cc         \
    $(LIBYUV_ROOT_REL)/source/scale_mmi.cc         \
    $(LIBYUV_ROOT_REL)/source/scale_msa.cc         \
    $(LIBYUV_ROOT_REL)/source/scale_neon.cc        \
    $(LIBYUV_ROOT_REL)/source/scale_neon64.cc      \
    $(LIBYUV_ROOT_REL)/source/scale_uv.cc          \
    $(LIBYUV_ROOT_REL)/source/scale_win.cc         \
    $(LIBYUV_ROOT_REL)/source/video_common.cc

common_CFLAGS := -Wall -fexceptions
ifneq ($(LIBYUV_DISABLE_JPEG), "yes")
LOCAL_SRC_FILES += \
    $(LIBYUV_ROOT_REL)/source/convert_jpeg.cc      \
    $(LIBYUV_ROOT_REL)/source/mjpeg_decoder.cc     \
    $(LIBYUV_ROOT_REL)/source/mjpeg_validate.cc
common_CFLAGS += -DHAVE_JPEG
LOCAL_SHARED_LIBRARIES := libjpeg
$(warning LIBYUV_DISABLE_JPEG $(LIBYUV_DISABLE_JPEG))

endif

LOCAL_CFLAGS += $(common_CFLAGS)
LOCAL_EXPORT_C_INCLUDES := $(LIBYUV_ROOT_ABS)/include
LOCAL_C_INCLUDES += $(LIBYUV_ROOT_ABS)/include
LOCAL_EXPORT_C_INCLUDE_DIRS := $(LIBYUV_ROOT_ABS)/include

# lib static
LOCAL_EXPORT_LDLIBS := -llog

LOCAL_MODULE := yuv_static
LOCAL_MODULE_TAGS := optional
ifeq ($(filter $(modules-get-list), $(LOCAL_MODULE)),)
    include $(BUILD_STATIC_LIBRARY)
endif
LIBYUV_LOCAL_$(LIBYUV_LIB_TYPE)_LIBRARIES += $(LOCAL_MODULE)

# lib share
ifeq ($(LIBYUV_LIB_TYPE), SHARED)
  include $(CLEAR_VARS)
  LOCAL_EXPORT_LDLIBS += -llog

  LOCAL_WHOLE_STATIC_LIBRARIES = yuv_static
  LOCAL_DISABLE_FATAL_LINKER_WARNINGS := true

  LOCAL_MODULE := yuv
  ifneq ($(LIBYUV_DISABLE_JPEG), "yes")
  LOCAL_SHARED_LIBRARIES := libjpeg
  endif
  ifeq ($(filter $(modules-get-list), $(LOCAL_MODULE)),)
      include $(BUILD_SHARED_LIBRARY)
  endif
  LIBYUV_LOCAL_$(LIBYUV_LIB_TYPE)_LIBRARIES += $(LOCAL_MODULE)
endif
