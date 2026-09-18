# iiWhatsNew

C++20 및 Qt 6.8.3 Core를 사용하는 버전 0.1.0 동적 플레이스홀더 라이브러리이다.
공개 함수 `iiWhatsNew::helloWorld()`는 `QString` 값 `Hello world!`를 반환한다.
새 소식 조회·표시 등 제품 기능은 아직 구현하지 않았다.

```cpp
#include <iiWhatsNew.h>

const QString message = iiWhatsNew::helloWorld();
```

## 빌드·테스트·설치

CMake 3.24 이상, C++20 컴파일러, Qt 6.8.3 Core 개발 패키지가 필요하다.
외부 의존성은 기존 Qt Core 하나이며, 추가 라이브러리를 다운로드하지 않는다.
Qt의 이용·배포 조건은 사용하는 Qt 배포본의 라이선스를 따른다.

```sh
./install.sh
```

스크립트는 `build/`에서 Release 빌드와 CTest를 실행한 다음
`$HOME/.local/SDK/iiWhatsNew`에 설치한다. 이후 `build/consumer/build/`에서
독립 소비자를 빌드하고 설치된 패키지의 검색·링크·실행을 검증한다.
검증은 정확한 반환 문자열, C++20 및 Qt 헤더 버전, 실행 중 Qt 버전을 확인한다.
기본 Qt 경로는 존재할 경우 `/Volumes/Storage/Qt/6.8.3/macos`를 사용한다.
다른 환경에서는 다음 변수를 지정한다.

```sh
QT_PREFIX_PATH=/path/to/Qt/6.8.3 INSTALL_PREFIX=/path/to/iiWhatsNew ./install.sh
```

`CMAKE_PREFIX_PATH` 환경 변수도 세미콜론으로 구분한 추가 CMake 검색 경로로 지원한다.
설치 결과는 `lib/`의 동적 라이브러리, `include/iiWhatsNew.h`,
`lib/cmake/iiWhatsNew/`의 패키지 설정과 `share/iiWhatsNew/README.md`이다.
소스 헤더와 구현은 프로젝트 루트에 함께 배치한다.

## 소비 프로젝트

```cmake
find_package(iiWhatsNew 0.1.0 CONFIG REQUIRED)
target_link_libraries(my_app PRIVATE iiWhatsNew::iiWhatsNew)
```

소비 프로젝트의 `CMAKE_PREFIX_PATH`에 설치 prefix와 Qt prefix를 지정한다.
공개 CMake 타깃이 C++20 요구 사항과 Qt6::Core 링크 의존성을 전파한다.
설치된 라이브러리를 실행하려면 Qt 6.8.3 런타임이 필요하다.

## License

SPDX-License-Identifier: AGPL-3.0-only

iiWhatsNew의 자체 작성 코드와 문서는 GNU Affero General Public License v3.0 전용으로
배포한다. 전체 조건은 [LICENSE](LICENSE)를 따른다.

Qt를 포함한 외부 라이브러리와 별도 고지가 있는 서드파티 코드는 각자의 라이선스를
유지한다. 이 프로젝트의 라이선스 선언은 해당 서드파티 라이선스를 대체하지 않는다.

## Source layout

Implementation files and their headers live together under `src/`. Existing feature and platform subdirectories retain their responsibilities. Build configuration, tests, documentation, resources, and maintenance scripts remain at the project root. Configure and build using the repository-local `build/` directory.
