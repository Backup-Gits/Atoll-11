#!/usr/bin/env bash
# azure-clang 14

# Main environtment
KERNEL_DIR=$(pwd)
PARENT_DIR="$(dirname "$KERNEL_DIR")"
KERN_IMG=$KERNEL_DIR/out/arch/arm64/boot/Image.gz

# Build kernel
export PATH="$PARENT_DIR/azure-clang/bin:$PATH"
export LD_LIBRARY_PATH="$PARENT_DIR/azure-clang/lib:$LD_LIBRARY_PATH"
export KBUILD_BUILD_USER="Miatoll"
export KBUILD_BUILD_HOST="kernel"
export TZ="Europe/Paris"

build_clang () {
    make -j$(nproc --all) O=out \
                          ARCH=arm64 \
                          CC=clang \
                          LD=ld.lld \
                          AR="llvm-ar" \
                          NM="llvm-nm" \
                          OBJCOPY="llvm-objcopy" \
                          OBJDUMP="llvm-objdump" \
                          STRIP="llvm-strip" \
                          CROSS_COMPILE=aarch64-linux-gnu- \
                          CROSS_COMPILE_ARM32=arm-linux-gnueabi-
}

make O=out ARCH=arm64 cust_defconfig
build_clang


