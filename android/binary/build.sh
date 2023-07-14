#!/bin/sh
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function copy_header_files() {
    local src_dir="$1"  # 源目录
    local dst_dir="$2"  # 目标目录
    
    # 创建目标目录（如果不存在）
    mkdir -p "$dst_dir"
    
    # 遍历源目录中的所有 .h 文件
    for file in "$src_dir"/*.h; do
        # 提取文件名
        filename=$(basename "$file")
        # 拷贝文件到目标目录
        cp "$file" "$dst_dir/$filename"
    done
}

function copy_lib_files() {
    local src_dir="$1"  # 源目录
    local dst_dir="$2"  # 目标目录
    
    # 创建目标目录
    mkdir -p "$dst_dir"
    
    # 遍历源目录的二级子目录
    for dir in "$src_dir"/*; do
        # 检查是否是目录
        if [ -d "$dir" ]; then
            # 获取目录名
            dirname=$(basename "$dir")
            
            # 在目标目录中创建对应的目录
            mkdir -p "$dst_dir/$dirname"
            
            # 复制 .a 和 .so 文件到目标目录
            cp "$dir"/*.a "$dst_dir/$dirname"
            cp "$dir"/*.so "$dst_dir/$dirname"
        fi
    done
}

LIBYUV_DIR="$DIR/../../libyuv"
LIB_DIR=""$DIR"/lib"
INCLUDE_DIR=""$DIR"/include"

BUILD_LIBS_DIR="$DIR/libs"
BUILD_OBJ_DIR="$DIR/obj"

rm -rf "$LIB_DIR"
rm -rf "$INCLUDE_DIR"

# build
ndk-build NDK_PROJECT_PATH=$DIR APP_BUILD_SCRIPT=$DIR/../source/Android.mk -e LIBYUV_DISABLE_JPEG=\"yes\" clean
ndk-build NDK_PROJECT_PATH=$DIR APP_BUILD_SCRIPT=$DIR/../source/Android.mk -e LIBYUV_DISABLE_JPEG=\"yes\"

copy_lib_files "$BUILD_OBJ_DIR/local" "$LIB_DIR"
copy_header_files "$LIBYUV_DIR/include" "$INCLUDE_DIR"
copy_header_files "$LIBYUV_DIR/include/libyuv" "$INCLUDE_DIR/libyuv"

rm -rf "$BUILD_LIBS_DIR"
rm -rf "$BUILD_OBJ_DIR"
