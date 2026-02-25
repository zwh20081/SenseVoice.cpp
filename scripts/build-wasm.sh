#!/usr/bin/env bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
BUILD_DIR="${REPO_ROOT}/build-wasm"
BUILD_TYPE="${BUILD_TYPE:-Release}"

if ! command -v emcmake >/dev/null 2>&1; then
    echo "error: emcmake not found. Please install and activate Emscripten SDK first."
    exit 1
fi

cd "${REPO_ROOT}"
git submodule sync
git submodule update --init --recursive

emcmake cmake -B "${BUILD_DIR}" \
    -DCMAKE_BUILD_TYPE="${BUILD_TYPE}" \
    -DBUILD_SHARED_LIBS=OFF \
    -DSENSE_VOICE_BUILD_EXAMPLES=OFF

cmake --build "${BUILD_DIR}" --config "${BUILD_TYPE}"
