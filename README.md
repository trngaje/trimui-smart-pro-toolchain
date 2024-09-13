# Golang Trimui Smart Pro Toolchain Docker image

Initially based on the [s0ckz TSP Toolchain](https://github.com/s0ckz/trimui-smart-pro-toolchain). The toolchain and sysroot files used here are originally [here](https://github.com/trimui/toolchain_sdk_smartpro/releases/tag/20231018).
The image support the cross-compilation of `arm64` binaries on `amd64` systems. It works on WSL. The image Includes:

- Official Trimui SDK
- Recommended linaro aarch64 gcc compiler
- SDL2 version provided by Trimui
- Golang 1.23 support and related configurations

## Installation

With Docker installed and running, `make shell` builds the toolchain and drops into a shell inside the container. The container's `~/workspace` is bound to `./workspace` by default.

After building the first time, `make shell` will skip building and drop into the shell.

## Workflow

- On your host machine, clone repositories into `./workspace` and make changes as usual.
- In the container shell, find the repository in `~/workspace` and build as usual.

## Docker for Mac

This image is still not running properly on Mac (M1) the SDL2 build proccess fail.

## Using with GitHub Actions

Here's an example of how to integrate this image on a GitHub release workflow: [https://github.com/anibaldeboni/screech/blob/master/.github/workflows/release.yml](https://github.com/anibaldeboni/screech/blob/master/.github/workflows/release.yml)
