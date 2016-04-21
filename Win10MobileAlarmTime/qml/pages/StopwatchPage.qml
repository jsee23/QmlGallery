import QtQuick 2.6
import Qt.labs.controls 1.0
import jsee23.universal 0.1

Page {
    id: fourthPage

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
                text: "Teilen"
                icon: "\uE72D"
                enabled: false
            }
        }
    }
}
