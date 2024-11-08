FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

# Set timezone
ENV TZ=America/Sao_Paulo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Install dependencies and update CA certificates
RUN dpkg --add-architecture arm64 && \
    apt-get update && apt-get install -y --no-install-recommends \
        wget \
        build-essential \
        ca-certificates \
        libc6 \
        libc6-dev \
        qemu \
        qemu-user-static \
        binfmt-support \
        linux-libc-dev-arm64-cross \
        libc6-arm64-cross \
        libc6-dev-arm64-cross \
        binutils-aarch64-linux-gnu \
        zip \
    && rm -rf /var/lib/apt/lists/*

# Install Go 1.23
RUN wget https://go.dev/dl/go1.23.1.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.23.1.linux-amd64.tar.gz && \
    rm go1.23.1.linux-amd64.tar.gz

ENV PATH="/usr/local/go/bin:${PATH}"

RUN wget https://github.com/pthalin/SDK_Trimui_Smart_Pro/releases/download/SDK_with_sysroot_Trimui_Smart_Pro_20231018_patched/SDK_with_sysroot_Trimui_Smart_Pro_20231018_patched.tar.gz && \
    tar -C / -xzf SDK_with_sysroot_Trimui_Smart_Pro_20231018_patched.tar.gz && \
    rm SDK_with_sysroot_Trimui_Smart_Pro_20231018_patched.tar.gz

ENV PATH="/opt/aarch64-linux-gnu-7.5.0-linaro/bin:${PATH}"
ENV SYSROOT="/opt/aarch64-linux-gnu-7.5.0-linaro/sysroot"

# Set environment variables for cross-compilation
ENV CC="aarch64-linux-gnu-gcc --sysroot=${SYSROOT}"
ENV CXX="aarch64-linux-gnu-g++ --sysroot=${SYSROOT}"
ENV LD="aarch64-linux-gnu-ld --sysroot=${SYSROOT}"
ENV AR="aarch64-linux-gnu-ar"
ENV AS="aarch64-linux-gnu-as"
ENV RANLIB="aarch64-linux-gnu-ranlib"
ENV STRIP="aarch64-linux-gnu-strip"
ENV GOOS="linux"
ENV GOARCH="arm64"
ENV CGO_ENABLED="1"
ENV CGO_LDFLAGS="-L${SYSROOT}/usr/lib  -L/usr/lib/aarch64-linux-gnu -lSDL2_image -lSDL2_ttf -lSDL2 -ldl -lpthread -lm"
ENV CGO_CFLAGS="-I${SYSROOT}/usr/include -I/usr/aarch64-linux-gnu/include -I/usr/aarch64-linux-gnu/include/SDL2 -I/usr/include/SDL2 -D_REENTRANT"

RUN useradd -m toolchain
USER toolchain
RUN mkdir -p /home/toolchain/workspace

WORKDIR /home/toolchain/workspace
