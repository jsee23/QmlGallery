import QtQuick 2.6
import Qt.labs.templates 1.0 as T
import Qt.labs.controls.universal 1.0

T.ItemDelegate {
    id: control

    implicitWidth: background ? background.implicitWidth : 0
    implicitHeight: background ? background.implicitHeight : 0
    baselineOffset: contentItem.y + contentItem.baselineOffset

    padding: 12
    spacing: 12

    onClicked: {
        modelData.clicked()
    }

    //! [contentItem]
    contentItem: Text {
        leftPadding: control.checkable && control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.checkable && !control.mirrored ? control.indicator.width + control.spacing : 0

        text: control.text
        font: control.font
        color: control.enabled ? Universal.baseHighColor : "#BDBEBF" // TODO
        elide: Text.ElideRight
        visible: control.text
        horizontalAlignment: Text.AlignLeft
        verticalAlignment: Text.AlignVCenter
    }
    //! [contentItem]

    //! [indicator]
    indicator: Item { }
    //! [indicator]

    //! [background]
    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 51
        color: Universal.chromeMediumLowColor

        Rectangle {
            anchors.fill: parent
            anchors.topMargin: 7
            anchors.bottomMargin: 7
            visible: control.pressed
            color: Universal.listLowColor
        }
    }
    //! [background]
}
