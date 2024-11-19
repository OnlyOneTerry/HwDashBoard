cmake_minimum_required(VERSION 3.14)

project(HWDashBoard VERSION 0.1 LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

link_directories(/opt/sysroot/lib)
link_directories(/opt/sysroot/usr/lib)
include_directories(/opt/sysroot/usr/include)

find_package(QT NAMES Qt6 Qt5 COMPONENTS Core Quick REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick REQUIRED)

set(HEAD_FILE
   CanUtil.h
   GlobalEnv.h
    )

set(SOURCE_FILE
    CanUtil.cpp
    GlobalEnv.cpp
    )

set(PROJECT_SOURCES
        main.cpp
        qml.qrc
        ${HEAD_FILE}
        ${SOURCE_FILE}
        )

 #add subdirectory
 include_directories(${PROJECT_SOURCE_DIR})
 include_directories(${PROJECT_SOURCE_DIR}/mhu_components)

if(${QT_VERSION_MAJOR} GREATER_EQUAL 6)
    qt_add_executable(HWDashBoard
        MANUAL_FINALIZATION
        ${PROJECT_SOURCES}
    )
# Define target properties for Android with Qt 6 as:
#    set_property(TARGET HWDashBoard APPEND PROPERTY QT_ANDROID_PACKAGE_SOURCE_DIR
#                 ${CMAKE_CURRENT_SOURCE_DIR}/android)
# For more information, see https://doc.qt.io/qt-6/qt-add-executable.html#target-creation
else()
    if(ANDROID)
        add_library(HWDashBoard SHARED
            ${PROJECT_SOURCES}
        )
# Define properties for Android with Qt 5 after find_package() calls as:
#    set(ANDROID_PACKAGE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}/android")
    else()
        add_executable(HWDashBoard
            ${PROJECT_SOURCES}
          )
      endif()
  endif()

  target_compile_definitions(HWDashBoard
    PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
  target_link_libraries(HWDashBoard
    PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick
    srv_component
    fastrtps
    srvcomp_conf
    can_parser
    CanMsg
    CanValueMsg
    )

  set_target_properties(HWDashBoard PROPERTIES
      MACOSX_BUNDLE_GUI_IDENTIFIER my.example.com
      MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
      MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
  )

if(QT_VERSION_MAJOR EQUAL 6)
    qt_import_qml_plugins(HWDashBoard)
    qt_finalize_executable(HWDashBoard)
endif()
