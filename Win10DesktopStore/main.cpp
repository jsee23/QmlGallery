#include <QGuiApplication>
#include <QtQml>
#include <QQmlApplicationEngine>

#include "qml/jsee23/universal/qquickuaptitlebar.h"

int main(int argc, char *argv[])
{
    qputenv("QT_AUTO_SCREEN_SCALE_FACTOR", QString("1").toLatin1());
    qputenv("QT_LABS_CONTROLS_STYLE", QString("universal").toLatin1());

    qmlRegisterType<QQuickUapTitleBar>("jsee23.universal", 0, 1, "TitleBar");

    qmlRegisterType(QUrl("qrc:/qml/jsee23/universal/StaticTabBar.qml"), "jsee23.universal", 0, 1, "StaticTabBar");
    qmlRegisterType(QUrl("qrc:/qml/jsee23/universal/SearchBox.qml"), "jsee23.universal", 0, 1, "SearchBox");

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/qml/main.qml")));

    return app.exec();
}
