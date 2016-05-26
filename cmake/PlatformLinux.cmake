message(STATUS "Configuring for platform Linux/GCC.")

# Enable C++11 support

execute_process(COMMAND ${CMAKE_C_COMPILER} -dumpversion
	OUTPUT_VARIABLE GCC_VERSION)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

set(LINUX_COMPILE_DEFS
	LINUX	                  # Linux system
)
set(DEFAULT_COMPILE_DEFS_DEBUG
    ${LINUX_COMPILE_DEFS}
    _DEBUG	                  # Debug build
)
set(DEFAULT_COMPILE_DEFS_RELEASE
    ${LINUX_COMPILE_DEFS}
    NDEBUG	                  # Release build
)
set(DEFAULT_COMPILE_DEFS_RELWITHDEBINFO
    ${LINUX_COMPILE_DEFS}
    NDEBUG	                  # Release with debug info build
)

set(LINUX_COMPILE_FLAGS
    -Wno-error=unknown-pragmas
    -fvisibility=hidden
    -pthread
    -pipe
    -fPIC
    -fno-rtti
    -Wreturn-type
    -Wfloat-equal
    -Wcast-qual
    -Wcast-align
    -Wconversion
    -Werror
    -Wno-error=switch
    -fopenmp
)
# no-rtti       -> disable c++ rtti
# fPIC          -> use position independent code
# -fvisibility=hidden -> only export symbols with __attribute__ ((visibility ("default")))

set(LINUX_TEST_COMPILE_FLAGS
    -Wno-error=unknown-pragmas
    -fvisibility=hidden
    -pthread
    -pipe
    -fPIC
    -fno-rtti
    -Wreturn-type
    -Wcast-qual
    -Wcast-align
    -Werror
    -Wall
    -pedantic
    -Wno-error=switch
    -Wno-sign-compare
    -fopenmp
)

if(CMAKE_COMPILER_IS_GNUCXX)
    # gcc
    set(LINUX_COMPILE_FLAGS
        ${LINUX_COMPILE_FLAGS}
        -Wtrampolines
        -Wall
        -pedantic
    )

    set(LINUX_LINKER_FLAGS "-fopenmp")

elseif("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")

    # clang
    set(LINUX_COMPILE_FLAGS
        ${LINUX_COMPILE_FLAGS}
        -Weverything
        -Wno-sign-conversion
        -Wno-c++98-compat
        -Wno-c++98-compat-pedantic
        -Wno-padded
    )

    set(LINUX_LINKER_FLAGS "-fopenmp=libiomp5")
endif()


set(DEFAULT_COMPILE_FLAGS ${LINUX_COMPILE_FLAGS})

set(DEFAULT_LINKER_FLAGS_RELWITHDEBINFO ${LINUX_LINKER_FLAGS})
set(DEFAULT_LINKER_FLAGS_RELEASE ${LINUX_LINKER_FLAGS})
set(DEFAULT_LINKER_FLAGS_DEBUG ${LINUX_LINKER_FLAGS})
set(DEFAULT_LINKER_FLAGS ${LINUX_LINKER_FLAGS})
