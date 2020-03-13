# Install script for directory: /home/test/work/official/nRF5-SDK-for-Mesh/mesh

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Debug")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "TRUE")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/test/work/official/nRF5-SDK-for-Mesh/build/mesh/stack/cmake_install.cmake")
  include("/home/test/work/official/nRF5-SDK-for-Mesh/build/mesh/access/cmake_install.cmake")
  include("/home/test/work/official/nRF5-SDK-for-Mesh/build/mesh/bootloader/cmake_install.cmake")
  include("/home/test/work/official/nRF5-SDK-for-Mesh/build/mesh/bearer/cmake_install.cmake")
  include("/home/test/work/official/nRF5-SDK-for-Mesh/build/mesh/core/cmake_install.cmake")
  include("/home/test/work/official/nRF5-SDK-for-Mesh/build/mesh/dfu/cmake_install.cmake")
  include("/home/test/work/official/nRF5-SDK-for-Mesh/build/mesh/prov/cmake_install.cmake")
  include("/home/test/work/official/nRF5-SDK-for-Mesh/build/mesh/serial/cmake_install.cmake")
  include("/home/test/work/official/nRF5-SDK-for-Mesh/build/mesh/gatt/cmake_install.cmake")
  include("/home/test/work/official/nRF5-SDK-for-Mesh/build/mesh/friend/cmake_install.cmake")

endif()

