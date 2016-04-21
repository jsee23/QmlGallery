import QtQuick 2.6
import Qt.labs.templates 1.0 as T
import Qt.labs.controls.universal 1.0

T.TabBar {
    id: control

    property int contentCount: contentModel && contentModel.count ? control.contentModel.count : 0

    leftPadding: (width - (contentCount * 64)) / 2
    rightPadding: (width - (contentCount * 64)) / 2

    //! [contentItem]
    contentItem: Row {
        width: control.contentModel.length * 64
        height: 60

        Repeater {
            model: control.contentModel
        }
    }
    //! [contentItem]

    //! [background]
    background: Rectangle {
        color: control.Universal.chromeMediumColor
        implicitWidth: 200
        implicitHeight: 60
    }
    //! [background]
}
