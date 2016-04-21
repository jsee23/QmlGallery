import QtQuick 2.6
import Qt.labs.templates 1.0 as T
import Qt.labs.controls.universal 1.0

T.ToolBar {
    id: control

    property list<AppBarSecondaryCommand> secondaryCommands
    onSecondaryCommandsChanged: {
        for (var i=0; i < secondaryCommands.length; i++) {
            secondaryCommands[i].__appBar = control
        }
    }

    property Component itemDelegate

    property bool isCompact: true

    implicitHeight: background ? background.implicitHeight : 0

    contentWidth: contentItem.implicitWidth || (contentChildren.length === 1 ? contentChildren[0].implicitWidth : 0)
    contentHeight: contentItem.implicitHeight || (contentChildren.length === 1 ? contentChildren[0].implicitHeight : 0)

    function closeAppBar() {
        isCompact = true
    }

    //! [contentItem]
    contentItem: Item { }
    //! [contentItem]

    //! [background]
    background: Rectangle {
        implicitHeight: control.isCompact ? 48 : 64
        Behavior on height {
            NumberAnimation { duration: 100 }
        }

        color: control.Universal.chromeMediumColor

        Rectangle {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            width: 64
            color: extenderArea.pressed ? control.Universal.listMediumColor : "transparent"

            Text {
                width: parent.width
                height: 48
                font.family: "Segoe MDL2 Assets"
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                text: "\ue712"
                color: "white" // TODO
            }

            MouseArea {
                id: extenderArea
                anchors.fill: parent
                onClicked: control.isCompact = !control.isCompact
            }
        }

        MouseArea {
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.top
            height: 1000 // TODO

            visible: !control.isCompact
            z: secondaryListView - 1
            onPressed: control.closeAppBar()
        }

        //! [secondaryCommands]
        ListView {
            id: secondaryListView
            z: 1000
            interactive: false

            // TODO: animation is not good...
            height: control.isCompact ? 0 : count * 51
            Behavior on height {
                NumberAnimation { duration: 100 }
            }
            visible: height != 0

            verticalLayoutDirection: ListView.BottomToTop

            anchors.left: parent.left
            anchors.right: parent.right
            anchors.bottom: parent.top

            model: control.secondaryCommands
            delegate: control.itemDelegate

            Rectangle {
                anchors.bottom: parent.top
                anchors.left: parent.left
                anchors.right: parent.right
                height: 1
                color: Universal.chromeHighColor
            }
        }
        //! [secondaryCommands]
    }
    //! [background]
}
