TEMPLATE = app

QT += qml quick labstemplates-private
CONFIG += c++11

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

HEADERS += \
    jsee23/universal/private/qquickappbutton.h

SOURCES += main.cpp \
    jsee23/universal/private/qquickappbutton.cpp
