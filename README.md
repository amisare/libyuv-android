This repository provides a Android.mk build configuration for [libyuv](https://chromium.googlesource.com/libyuv/libyuv).

## Usage

### Integration

Then add this repo as a submodule to your own project.

```
git submodule add https://github.com/amisare/libyuv-android.git libyuv-android
git submodule update --recurse-submodules
```

#### Source code integration

Add android/source/Android.mkto your project Android.mk

```
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

# begin libyuv
LIBYUV_PATH := $(LOCAL_PATH)/<path to>/libyuv-android/android/source/Android.mk
# LIBYUV_LIB_TYPE := STATIC
# or
# LIBYUV_LIB_TYPE := SHARED
include $(LIBYUV_PATH)

include $(CLEAR_VARS)

LOCAL_C_INCLUDES += $(LIBYUV_LOCAL_C_INCLUDES)
LOCAL_EXPORT_C_INCLUDES += $(LIBYUV_LOCAL_EXPORT_C_INCLUDES)
LOCAL_STATIC_LIBRARIES += $(LIBYUV_LOCAL_STATIC_LIBRARIES)
LOCAL_SHARED_LIBRARIES += $(LIBYUV_LOCAL_SHARED_LIBRARIES)
# end libyuv

# your config

```

#### Binary integration

Add android/binary/Android.mk to your project Android.mk

```
LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

# begin libyuv
LIBYUV_PATH := $(LOCAL_PATH)/<path to>/libyuv-android/android/binary/Android.mk
# LIBYUV_LIB_TYPE := STATIC
# or
# LIBYUV_LIB_TYPE := SHARED
include $(LIBYUV_PATH)

include $(CLEAR_VARS)

LOCAL_C_INCLUDES += $(LIBYUV_LOCAL_C_INCLUDES)
LOCAL_EXPORT_C_INCLUDES += $(LIBYUV_LOCAL_EXPORT_C_INCLUDES)
LOCAL_STATIC_LIBRARIES += $(LIBYUV_LOCAL_STATIC_LIBRARIES)
LOCAL_SHARED_LIBRARIES += $(LIBYUV_LOCAL_SHARED_LIBRARIES)
# end libyuv

# your config
```

## Updating

### Clone

This repo uses [Git Submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) to bring in dependent components.

```
git clone https://github.com/amisare/libyuv-android.git --recurse-submodules
```

If you have downloaded the repo without using the `--recurse-submodules` argument, you need to run:
```
git submodule update --init --recursive
```

### Modify

The [libyuv](https://chromium.googlesource.com/libyuv/libyuv) is a submodule of [libyuv-android](https://github.com/amisare/libyuv-android.git).

### Build and check

#### Source code

Testing build

```
cd android/source
ndk-build NDK_PROJECT_PATH=$(pwd) APP_BUILD_SCRIPT=$(pwd)/Android.mk
```

#### Binary

**It successfully run only on macOS, without attempting on other systems.**

Run build script
```
cd android/binary
./build.sh
```
