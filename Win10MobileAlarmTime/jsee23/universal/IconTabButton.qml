import QtQuick 2.6
import Qt.labs.templates 1.0 as T
import Qt.labs.controls.universal 1.0

T.TabButton {
    id: control

    implicitWidth: 64
    implicitHeight: 60

    property string icon
    property url iconSource

    //! [contentItem]
    contentItem: Item {
        Text {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 13
            horizontalAlignment: Text.AlignHCenter
            height: 16
            color: control.checked ? Universal.accent : Universal.baseHighColor
            text: control.icon
            font.family: "Segoe MDL2 Assets"
            font.pixelSize: 16
        }

        Text {
            anchors.top: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.topMargin: 36
            text: control.text
            color: control.checked ? Universal.accent : Universal.baseHighColor
            horizontalAlignment: Text.AlignHCenter
            font.family: "Segoe UI"
            font.pixelSize: 12
        }

        Image {
            anchors.top: parent.top
            anchors.topMargin: 12
            anchors.horizontalCenter: parent.horizontalCenter
            width: 16
            height: 16
            source: control.iconSource ? control.iconSource : ""
        }
    }
    //! [contentItem]

    //! [background]
    background: Item {

        Rectangle {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            height: 2
            color: Universal.accent
            visible: control.checked
        }

    }
    //! [background]
}
