# iiWhatsNew

A version 0.1.0 dynamic placeholder library using C++20 and Qt 6.8.3 Core. Public function `iiWhatsNew::helloWorld()` returns `QString` value `Hello world!`. Product features such as new news inquiry and display have not yet been implemented.

```cpp
#include <iiWhatsNew.h>

const QString message = iiWhatsNew::helloWorld();
```

<a id="빌드테스트설치"></a>

## Build·Test·Install

CMake 3.24 and above, C++20 compiler, and Qt 6.8.3 Core development package are required. External dependencies consist of one existing Qt Core, and no additional libraries are downloaded. Qt's usage and distribution conditions follow the license of the used Qt distribution.

```sh
./install.sh
```

The script runs Release build and CTest from `build/` and then installs to `$HOME/.local/SDK/iiWhatsNew`. Subsequently, it builds and installs an independent consumer from `build/consumer/build/` and verifies search, link, and execution of the installed package. Verification checks for exact return strings, C++20 and Qt header versions, and Qt version during execution. The default Qt path is used if `/Volumes/Storage/Qt/6.8.3/macos` exists. In other environments, the following variables are specified.

```sh
QT_PREFIX_PATH=/path/to/Qt/6.8.3 INSTALL_PREFIX=/path/to/iiWhatsNew ./install.sh
```

The `CMAKE_PREFIX_PATH` environment variable also supports additional CMake search paths separated by semicolons. Installation results are `lib/` dynamic library, `include/iiWhatsNew.h`, `lib/cmake/iiWhatsNew/` package settings, and `share/iiWhatsNew/README.md`.

<a id="소비-프로젝트"></a>

## Consumer project

```cmake
find_package(iiWhatsNew 0.1.0 CONFIG REQUIRED)
target_link_libraries(my_app PRIVATE iiWhatsNew::iiWhatsNew)
```

Specify the installation prefix and the Qt prefix in the consumer project's `CMAKE_PREFIX_PATH`. The public CMake target propagates the C++20 requirements and Qt6::Core link dependency. Running the installed library requires the Qt 6.8.3 runtime.

## License

SPDX-License-Identifier: AGPL-3.0-only

Self-written code and documents of iiWhatsNew are distributed exclusively under the GNU Affero General Public License v3.0. The full terms follow [LICENSE](LICENSE).

External libraries including Qt and third-party code with separate notices maintain their own licenses. This project's license declaration does not replace the corresponding third-party license.

## Source layout

Implementation files and their headers live together under `src/`. Existing feature and platform subdirectories retain their responsibilities. Build configuration, tests, documentation, resources, and maintenance scripts remain at the project root. Configure and build using the repository-local `build/` directory.
