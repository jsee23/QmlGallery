import QtQuick 2.6
import Qt.labs.controls 1.0
import Qt.labs.controls.universal 1.0
import jsee23.universal 0.1

ApplicationWindow {
    id: root
    visible: true
    width: 360
    height: 640

    Universal.theme: Universal.Dark

    header: IconTabBar {
        id: tabbar
        height: 60
        onCurrentIndexChanged: view.currentIndex = currentIndex

        IconTabButton {
            text: "Wecker"
            iconSource: checked ? "qrc:/img/clockalarm_checked.png" : "qrc:/img/clockalarm.png"
        }
        IconTabButton {
            text: "Weltuhr"
            iconSource: checked ? "qrc:/img/worldclock_checked.png" : "qrc:/img/worldclock.png"
        }
        IconTabButton {
            text: "Zeitgeber"
            iconSource: checked ? "qrc:/img/stopwatch_checked.png" : "qrc:/img/stopwatch.png"
        }
        IconTabButton {
            text: "Stoppuhr"
            icon: "\ue916"
        }
    }

    Component.onCompleted: Universal.accent = Universal.Cyan

    SwipeView {
        id: view
        anchors.fill: parent
        onCurrentIndexChanged: tabbar.currentIndex = currentIndex

        ClockAlarmPage { }
        WorldClockPage { }
        CountdownPage { }
        StopwatchPage { }
    }
}
