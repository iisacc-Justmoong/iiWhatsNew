#!/usr/bin/env bash
set -euo pipefail

SDK_SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SDK_BUILD_DIR="${SDK_SOURCE_DIR}/build"
SDK_INSTALL_PREFIX="${INSTALL_PREFIX:-${HOME}/.local/SDK/iiWhatsNew}"
SDK_QT_PREFIX="${QT_PREFIX_PATH:-}"
if [[ -z "${SDK_QT_PREFIX}" && -f "${HOME}/Qt/6.8.3/macos/lib/cmake/Qt6/Qt6Config.cmake" ]]; then
    SDK_QT_PREFIX="${HOME}/Qt/6.8.3/macos"
fi
SDK_PREFIX_PATH="${SDK_QT_PREFIX}"
if [[ -n "${CMAKE_PREFIX_PATH:-}" ]]; then
    SDK_PREFIX_PATH="${SDK_PREFIX_PATH:+${SDK_PREFIX_PATH};}${CMAKE_PREFIX_PATH}"
fi

cmake -S "${SDK_SOURCE_DIR}" -B "${SDK_BUILD_DIR}" \
    -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=ON \
    -DCMAKE_INSTALL_PREFIX="${SDK_INSTALL_PREFIX}" \
    -DCMAKE_PREFIX_PATH="${SDK_PREFIX_PATH}" \
    -DCMAKE_EXPORT_COMPILE_COMMANDS=ON
cmake --build "${SDK_BUILD_DIR}" --config Release --parallel
ctest --test-dir "${SDK_BUILD_DIR}" -C Release --output-on-failure
cmake --install "${SDK_BUILD_DIR}" --config Release

cmake -S "${SDK_SOURCE_DIR}/tests/consumer" -B "${SDK_BUILD_DIR}/consumer/build" \
    -DCMAKE_BUILD_TYPE=Release \
    -DiiWhatsNew_DIR="${SDK_INSTALL_PREFIX}/lib/cmake/iiWhatsNew" \
    -DCMAKE_PREFIX_PATH="${SDK_INSTALL_PREFIX};${SDK_PREFIX_PATH}"
cmake --build "${SDK_BUILD_DIR}/consumer/build" --config Release --parallel
ctest --test-dir "${SDK_BUILD_DIR}/consumer/build" -C Release --output-on-failure
