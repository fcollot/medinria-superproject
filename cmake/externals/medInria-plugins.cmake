function(medInria_plugins_project)

    set(medInria-plugins-minvers ${MEDINRIA_VERSION} PARENT_SCOPE)
    set(medInria-plugins-package-name medinria-plugins PARENT_SCOPE)

    PackageInit(medInria-plugins medInria-plugins medInria-plugins OFF)
    if (TARGET medInria-plugins)
        return()
    endif()

    ParseProjectArguments(medInria-plugins medInriaPluginsp "TEST" "" ${ARGN})

    set(medInriaPluginsp_TESTING OFF)
    if (${medInriaPluginsp_TEST})
        set(medInriaPluginsp_TESTING ON)
    endif()

    if (NOT DEFINED location)
        set(location GIT_REPOSITORY "git@github.com:medInria/medInria-plugins.git")
    endif()

    SetExternalProjectsDirs(medInria-plugins ep_build_dirs)
    ExternalProject_Add(medInria-plugins
        ${ep_build_dirs}
        ${location}
        UPDATE_COMMAND ""
        CMAKE_GENERATOR ${gen}
        CMAKE_ARGS
            -DCMAKE_INSTALL_PREFIX:PATH=<INSTALL_DIR>
        CMAKE_CACHE_ARGS
            ${ep_common_cache_args}
            -Ddtk_DIR:FILEPATH=${dtk_DIR}
            -DDCMTK_DIR:FILEPATH=${DCMTK_DIR}
            -DDCMTK_SOURCE_DIR:FILEPATH=${DCMTK_SOURCE_DIR}
            -DITK_DIR:FILEPATH=${ITK_DIR}
            -DQTDCM_DIR:FILEPATH=${QTDCM_DIR}
            -DVTK_DIR:FILEPATH=${VTK_DIR}
            -DTTK_DIR:FILEPATH=${TTK_DIR}
            -DmedInria_DIR:FILEPATH=${medInria_DIR}
            -DMEDINRIA_BUILD_TOOLS:BOOL=ON
            -DRPI_DIR:FILEPATH=${RPI_DIR}
            -DQT_QMAKE_EXECUTABLE:FILEPATH=${QT_QMAKE_EXECUTABLE}
        DEPENDS dtk medInria dcmtk ITK VTK TTK QtDcm RPI
    )
    ExternalForceBuild(medInria-plugins)

    ExternalProject_Get_Property(medInria-plugins binary_dir)
    set(medInria-plugins_DIR ${binary_dir} PARENT_SCOPE)

endfunction()
