TEMPLATE = app

QT += qml quick core-private
CONFIG += c++11

SOURCES += main.cpp \
    qml/jsee23/universal/qquickuaptitlebar.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    qml/jsee23/universal/qquickuaptitlebar.h
