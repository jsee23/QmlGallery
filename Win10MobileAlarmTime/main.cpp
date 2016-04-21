#include <QGuiApplication>
#include <QtQml>
#include <QQmlApplicationEngine>

#include "jsee23/universal/private/qquickappbutton.h"

int main(int argc, char *argv[])
{
    qputenv("QT_AUTO_SCREEN_SCALE_FACTOR", QString("1").toLatin1());
    qputenv("QT_LABS_CONTROLS_STYLE", QString("universal").toLatin1());

    qmlRegisterType<QQuickAppButton>("jsee23.universal.private", 0, 1, "AbstractAppButton");

    qmlRegisterType(QUrl("qrc:/jsee23/universal/AppBarButton.qml"), "jsee23.universal", 0, 1, "AppBarButton");
    qmlRegisterType(QUrl("qrc:/jsee23/universal/AppBarSecondaryCommand.qml"), "jsee23.universal", 0, 1, "AppBarSecondaryCommand");
    qmlRegisterType(QUrl("qrc:/jsee23/universal/AppBarItemDelegate.qml"), "jsee23.universal", 0, 1, "AppBarItemDelegate");
    qmlRegisterType(QUrl("qrc:/jsee23/universal/AppBar.qml"), "jsee23.universal", 0, 1, "AppBar");
    qmlRegisterType(QUrl("qrc:/jsee23/universal/IconTabButton.qml"), "jsee23.universal", 0, 1, "IconTabButton");
    qmlRegisterType(QUrl("qrc:/jsee23/universal/IconTabBar.qml"), "jsee23.universal", 0, 1, "IconTabBar");

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));

    return app.exec();
}
