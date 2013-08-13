######################################################################
# Communi
######################################################################

isEmpty(COMMUNI_MODULE):error(COMMUNI_MODULE must be set)

isEmpty(COMMUNI_INSTALL_LIBS):COMMUNI_INSTALL_LIBS = $$[QT_INSTALL_LIBS]
isEmpty(COMMUNI_INSTALL_BINS):COMMUNI_INSTALL_BINS = $$[QT_INSTALL_BINS]
isEmpty(COMMUNI_INSTALL_HEADERS):COMMUNI_INSTALL_HEADERS = $$[QT_INSTALL_HEADERS]/Communi

target.path = $$COMMUNI_INSTALL_LIBS
INSTALLS += target

dlltarget.path = $$COMMUNI_INSTALL_BINS
INSTALLS += dlltarget

macx:CONFIG(qt_framework, qt_framework|qt_no_framework) {
    CONFIG += lib_bundle debug_and_release
    CONFIG(debug, debug|release) {
        !build_pass:CONFIG += build_all
    } else { #release
        !debug_and_release|build_pass {
            FRAMEWORK_HEADERS.version = Versions
            FRAMEWORK_HEADERS.files = $$PUB_HEADERS $$CONV_HEADERS
            FRAMEWORK_HEADERS.path = Headers
        }
        QMAKE_BUNDLE_DATA += FRAMEWORK_HEADERS
    }
    QMAKE_LFLAGS_SONAME = -Wl,-install_name,$$COMMUNI_INSTALL_LIBS/
} else {
    headers.files = $$PUB_HEADERS $$CONV_HEADERS
    headers.path = $$COMMUNI_INSTALL_HEADERS/$$COMMUNI_MODULE
    INSTALLS += headers
}