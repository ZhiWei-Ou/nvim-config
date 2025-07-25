# =============================================================================
# File: test_main Author: Ouzw Email: ouzw.mail@gmail.com Created On:
# 2025-05-25 Description:
# ============================================================================

cmake_minimum_required(VERSION 3.10)

project(test_main)

# test cmake
message(STATUS "hello cmake")

add_executable(${PROJECT_NAME} test_main.c)
target_link_libraries(${PROJECT_NAME} PRIVATE m pthread)
