cmake_minimum_required(VERSION 3.24)
project(iiWhatsNew VERSION 0.1.0 LANGUAGES CXX)

if(PROJECT_IS_TOP_LEVEL AND CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(_sdk_home "$ENV{HOME}")
    if(_sdk_home STREQUAL "")
        set(_sdk_home "$ENV{USERPROFILE}")
    endif()
    set(CMAKE_INSTALL_PREFIX "${_sdk_home}/.local/SDK/iiWhatsNew" CACHE PATH
        "Installation prefix for iiWhatsNew" FORCE)
    unset(_sdk_home)
endif()

find_package(Qt6 6.8.3 EXACT REQUIRED COMPONENTS Core)
include(GNUInstallDirs)
include(CMakePackageConfigHelpers)
include(CTest)

add_library(iiWhatsNew SHARED src/iiWhatsNew.cpp src/iiWhatsNew.h)
add_library(iiWhatsNew::iiWhatsNew ALIAS iiWhatsNew)
target_compile_features(iiWhatsNew PUBLIC cxx_std_20)
target_compile_definitions(iiWhatsNew PRIVATE IIWHATSNEW_BUILDING_LIBRARY)
target_link_libraries(iiWhatsNew PUBLIC Qt6::Core)
target_include_directories(iiWhatsNew PUBLIC
    $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/src>
    $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
)
set_target_properties(iiWhatsNew PROPERTIES
    CXX_STANDARD 20
    CXX_STANDARD_REQUIRED ON
    CXX_EXTENSIONS OFF
    CXX_VISIBILITY_PRESET hidden
    VISIBILITY_INLINES_HIDDEN ON
    VERSION ${PROJECT_VERSION}
    SOVERSION 0
    INSTALL_RPATH_USE_LINK_PATH TRUE
)

if(BUILD_TESTING)
    add_executable(iiWhatsNewHelloWorldTest tests/hello_world.cpp)
    target_link_libraries(iiWhatsNewHelloWorldTest PRIVATE iiWhatsNew::iiWhatsNew)
    set_target_properties(iiWhatsNewHelloWorldTest PROPERTIES CXX_EXTENSIONS OFF)
    add_test(NAME iiWhatsNew.hello_world COMMAND iiWhatsNewHelloWorldTest)
endif()

install(TARGETS iiWhatsNew EXPORT iiWhatsNewTargets
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
install(FILES src/iiWhatsNew.h DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})
install(FILES README.md DESTINATION ${CMAKE_INSTALL_DATADIR}/iiWhatsNew)
install(EXPORT iiWhatsNewTargets
    FILE iiWhatsNewTargets.cmake NAMESPACE iiWhatsNew::
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/iiWhatsNew
)
configure_package_config_file(cmake/iiWhatsNewConfig.cmake.in
    ${CMAKE_CURRENT_BINARY_DIR}/iiWhatsNewConfig.cmake
    INSTALL_DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/iiWhatsNew
)
write_basic_package_version_file(
    ${CMAKE_CURRENT_BINARY_DIR}/iiWhatsNewConfigVersion.cmake
    VERSION ${PROJECT_VERSION} COMPATIBILITY SameMajorVersion
)
install(FILES
    ${CMAKE_CURRENT_BINARY_DIR}/iiWhatsNewConfig.cmake
    ${CMAKE_CURRENT_BINARY_DIR}/iiWhatsNewConfigVersion.cmake
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/iiWhatsNew
)
