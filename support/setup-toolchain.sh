#!/bin/bash -e
TOOLCHAIN_TAR="/root/aarch64-linux-gnu-7.5.0-linaro.tgz"
SYSROOT_TAR="/root/SDK_usr_tg5040_a133p.tgz"
SDL2="SDL2-2.26.1"
SDL2_TAR="/root/$SDL2.GE8300.tgz"
SDL2_TTF="SDL2_ttf-2.22.0"
SDL2_TTF_TAR="/root/$SDL2_TTF.tar.gz"
SDL2_IMAGE="SDL2_image-2.8.2"
SDL2_IMAGE_TAR="/root/$SDL2_IMAGE.tar.gz"

cd /opt
tar xf "${TOOLCHAIN_TAR}"

tar xf "${SDL2_TAR}" && \
mv /root/sdl2-config.cmake /opt/SDL2-2.26.1 && \
cd $SDL2 && \
./configure && make && make install &&\
cd ..

tar xf "${SDL2_TTF_TAR}" && \
cd $SDL2_TTF && \
./configure && make && make install && \
cd ..

tar xf "${SDL2_IMAGE_TAR}" && \
cd $SDL2_IMAGE && \
./configure && make && make install && \
cd ..

cd aarch64-linux-gnu-7.5.0-linaro
mkdir sysroot
cd sysroot
cp -a ../aarch64-linux-gnu/libc/* .
tar xf "${SYSROOT_TAR}"

rm -f "${TOOLCHAIN_TAR}" "${SYSROOT_TAR}" "${SDL2_TAR}"
