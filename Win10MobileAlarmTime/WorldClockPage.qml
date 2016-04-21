import QtQuick 2.6
import Qt.labs.controls 1.0
import jsee23.universal 0.1

Page {
    id: secondPage

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
                icon: "\uE128"
                enabled: false
            }
        }
    }
}
