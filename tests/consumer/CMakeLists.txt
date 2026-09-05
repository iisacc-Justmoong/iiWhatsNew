cmake_minimum_required(VERSION 3.24)
project(iiWhatsNewConsumer LANGUAGES CXX)

find_package(iiWhatsNew 0.1.0 CONFIG REQUIRED)
add_executable(iiWhatsNewConsumer ../hello_world.cpp)
target_link_libraries(iiWhatsNewConsumer PRIVATE iiWhatsNew::iiWhatsNew)
set_target_properties(iiWhatsNewConsumer PROPERTIES CXX_EXTENSIONS OFF)

enable_testing()
add_test(NAME iiWhatsNew.installed_consumer COMMAND iiWhatsNewConsumer)
