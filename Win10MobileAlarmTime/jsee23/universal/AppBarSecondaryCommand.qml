import QtQuick 2.6
import jsee23.universal 0.1

QtObject {
    signal clicked()
    property string text: ""

    property var __appBar
    onClicked: {
        if (__appBar)
            __appBar.closeAppBar()
    }
}
