import QtQuick 2.6
import Qt.labs.controls 1.0
import Qt.labs.controls.universal 1.0
import jsee23.universal 0.1

Page {
    id: firstPage

    ListView {
        anchors.fill: parent

        model: ["06:30", "07:00"]
        delegate: Item {
            width: firstPage.width
            height: index == 0 ? 126 : 106

            Item {
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.right: parent.right
                anchors.leftMargin: 15
                anchors.bottomMargin: 20
                anchors.rightMargin: 15
                height: 66

                Text {
                    anchors.left: parent.left
                    anchors.top: parent.top

                    color: Universal.baseHighColor
                    font.pixelSize: 20
                    font.family: "Segoe UI"
                    text: modelData
                }

                Text {
                    anchors.left: parent.left
                    anchors.bottom: repeatIndicator.top

                    color: onOffSwitch.checked ? Universal.accent : Universal.baseHighColor
                    font.pixelSize: 14
                    font.family: "Segoe UI"
                    font.bold: true
                    text: "Wecker"
                }

                Text {
                    id: repeatIndicator
                    anchors.left: parent.left
                    anchors.bottom: parent.bottom

                    color: Universal.baseMediumColor
                    font.pixelSize: 14
                    font.family: "Segoe UI"
                    text: "Einmalig"
                }

                Switch {
                    id: onOffSwitch
                    anchors.right: onOffSwitchText.left
                    anchors.rightMargin: 5
                    anchors.verticalCenter: parent.verticalCenter
                }

                Text {
                    id: onOffSwitchText
                    anchors.right: parent.right
                    anchors.verticalCenter: parent.verticalCenter

                    text: onOffSwitch.checked ? "Ein" : "Aus"
                    color: Universal.baseHighColor
                    font.pixelSize: 14
                    font.family: "Segoe UI"

                    width: 20
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
    }

    footer: AppBar {
        id: appbar

        itemDelegate: AppBarItemDelegate {
            width: appbar.width
            text: modelData.text
        }

        secondaryCommands: [
            AppBarSecondaryCommand { text: "Feedback senden" },
            AppBarSecondaryCommand { text: "Info" }
        ]

        Row {
            anchors.right: parent.right
            anchors.rightMargin: 64

            AppBarButton {
                text: "Neu"
                icon: "\ue710"
            }
            AppBarButton {
                text: "Verwalten"
                icon: "\ue133"
            }
        }
    }
}
