import QtQuick 2.6
import Qt.labs.templates 1.0 as T
import Qt.labs.controls.universal 1.0

T.TabBar {
    id: control

    property int contentCount: contentModel && contentModel.count ? control.contentModel.count : 0

    padding: 0

    //! [contentItem]
    contentItem: Row {
        width: control.width
        height: 60

        Repeater {
            model: control.contentModel
        }
    }
    //! [contentItem]

    //! [background]
    background: Item {
        implicitWidth: 200
        implicitHeight: 60
    }
    //! [background]
}
