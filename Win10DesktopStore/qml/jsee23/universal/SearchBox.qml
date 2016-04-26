import QtQuick 2.6
import Qt.labs.templates 1.0 as T
import Qt.labs.controls.universal 1.0

T.TextField {
    id: control

    implicitWidth: 234
    implicitHeight: 30

    signal startSearch()
    onStartSearch: {
        // lose the focus when search is started...
        control.focus = false
    }

    font.pixelSize: 12

    topPadding: 6
    bottomPadding: 6
    leftPadding: 12

    onAccepted: startSearch()

    Text {
        id: placeholder
        x: control.leftPadding
        y: control.topPadding
        width: control.width - (control.leftPadding + control.rightPadding)
        height: control.height - (control.topPadding + control.bottomPadding)

        text: control.placeholderText
        font: control.font
        color: "grey" /*!control.enabled ? control.Universal.chromeDisabledLowColor :
                control.activeFocus ? control.Universal.chromeBlackMediumLowColor : control.Universal.baseMediumColor */
        visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
        horizontalAlignment: control.horizontalAlignment
        verticalAlignment: control.verticalAlignment
        elide: Text.ElideRight
    }

    //! [background]
    background: Rectangle {
        implicitWidth: control.width
        implicitHeight: control.height

        border.width: 1 // TODO --> 2 = hovered
        border.color: "black"//!control.enabled ? control.Universal.baseLowColor :
                       //control.activeFocus ? control.Universal.accent : control.Universal.chromeDisabledLowColor
        color: control.enabled ? control.Universal.altHighColor : control.Universal.baseLowColor
    }
    //! [background]

    Rectangle {
        id: searchIconContainer

        width: 34
        height: 34
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color: searchIconArea.pressed ? Universal.accent : "transparent"

        Text {
            id: searchIcon
            anchors.centerIn: parent

            font.family: "Segoe MDL2 Assets"
            font.pixelSize: 16
            text: "\ue11a"
            verticalAlignment: Text.AlignVCenter

            color: searchIconArea.containsMouse ? searchIconArea.pressed ? "white" : Universal.accent : "black" // TODO

            MouseArea {
                id: searchIconArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: control.startSearch()
            }
        }
    }


    Rectangle {
        width: 34
        height: 34
        anchors.right: searchIconContainer.left
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color: clearIconArea.pressed ? Universal.accent : "transparent"
        visible: control.text != "" && control.focus

        Text {
            id: clearIcon
            anchors.centerIn: parent

            font.family: "Segoe MDL2 Assets"
            font.pixelSize: 16
            text: "\ue711"
            verticalAlignment: Text.AlignVCenter

            color: clearIconArea.containsMouse ? clearIconArea.pressed ? "white" : Universal.accent : "black" // TODO

            MouseArea {
                id: clearIconArea
                anchors.fill: parent
                hoverEnabled: true
                onClicked: control.text = ""
            }
        }
    }
}
