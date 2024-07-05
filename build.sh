#!/bin/bash

set -euxo pipefail

export PREFIX=/home/jjerphan/.local/miniforge3/envs/mamba
export BUILD_PREFIX=$PREFIX
export CARGO_BUILD_TARGET=x86_64-unknown-linux-gnu

cmake -B build \
      -GNinja \
      -DRust_CARGO_TARGET=${CARGO_BUILD_TARGET} \
      -DCMAKE_AR=$BUILD_PREFIX/bin/x86_64-conda-linux-gnu-ar \
      -DCMAKE_CXX_COMPILER_AR=$BUILD_PREFIX/bin/x86_64-conda-linux-gnu-gcc-ar \
      -DCMAKE_C_COMPILER_AR=$BUILD_PREFIX/bin/x86_64-conda-linux-gnu-gcc-ar \
      -DCMAKE_RANLIB=$BUILD_PREFIX/bin/x86_64-conda-linux-gnu-ranlib \
      -DCMAKE_CXX_COMPILER_RANLIB=$BUILD_PREFIX/bin/x86_64-conda-linux-gnu-gcc-ranlib \
      -DCMAKE_C_COMPILER_RANLIB=$BUILD_PREFIX/bin/x86_64-conda-linux-gnu-gcc-ranlib \
      -DCMAKE_LINKER=$BUILD_PREFIX/bin/x86_64-conda-linux-gnu-ld \
      -DCMAKE_STRIP=$BUILD_PREFIX/bin/x86_64-conda-linux-gnu-strip \
      -DCMAKE_BUILD_TYPE=Debug \
      -DCMAKE_FIND_ROOT_PATH_MODE_PROGRAM=NEVER \
      -DCMAKE_FIND_ROOT_PATH_MODE_LIBRARY=ONLY \
      -DCMAKE_FIND_ROOT_PATH_MODE_INCLUDE=ONLY \
      -DCMAKE_FIND_ROOT_PATH="$PREFIX;$BUILD_PREFIX/x86_64-conda-linux-gnu/sysroot" \
      -DCMAKE_INSTALL_PREFIX=$PREFIX \
      -DCMAKE_INSTALL_LIBDIR=lib \
      -DCMAKE_PROGRAM_PATH="$BUILD_PREFIX/bin;$PREFIX/bin" \
      -DRust_CARGO_TARGET=${CARGO_BUILD_TARGET}

cd build
ninja install
