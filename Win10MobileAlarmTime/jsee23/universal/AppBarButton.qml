import QtQuick 2.6
import Qt.labs.templates 1.0 as T
import Qt.labs.controls.universal 1.0
import jsee23.universal.private 0.1

//T.ToolButton {
AbstractAppButton {
    id: control

    implicitWidth: 64
    implicitHeight: 64

    property bool useSystemFocusVisuals: true
    property var __appBar

    property string icon

    onClicked: {
        if (__appBar)
            __appBar.closeAppBar()
    }

    //! [contentItem]
    contentItem: Item {
        Item {
            anchors.fill: parent
            anchors.bottomMargin: 16

            Text {
                anchors.fill: parent
                text: control.icon
                font.family: "Segoe MDL2 Assets"
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                color: control.enabled ? control.Universal.baseHighColor : control.Universal.baseLowColor
            }
        }

        Text {
            anchors.fill: parent
            anchors.topMargin: 48
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            text: control.text
            color: control.enabled ? control.Universal.baseHighColor : control.Universal.baseLowColor
            font.family: "Segoe UI"
            font.pixelSize: 11
        }
    }

    //! [contentItem]

    //! [background]
    background: Rectangle {
        implicitWidth: 64
        implicitHeight: 64 // AppBarThemeCompactHeight

        color: control.pressed ? control.Universal.listMediumColor :
               control.enabled && (control.highlighted || control.checked) ? control.Universal.accent : "transparent"
    }
    //! [background]
}
