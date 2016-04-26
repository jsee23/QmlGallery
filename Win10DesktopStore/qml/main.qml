import QtQuick 2.6
import Qt.labs.controls 1.0
import Qt.labs.controls.universal 1.0
import jsee23.universal 0.1
import "./pages"

ApplicationWindow {
    id: root

    visible: true
    width: 750
    height: 700

    header: Item {
        height: 38
        StaticTabBar {
            id: tabbar
            width: 250
            height: 38
            leftPadding: 10
            rightPadding: 10
            property int tabButtonPadding: 10

            TabButton {
                text: "Startseite"
                font.pixelSize: 11
                font.weight: Font.DemiBold
                checked: pageStack.currentItem == root.startPage

                // WORKAROUND
                padding: 0
                Component.onCompleted: padding = 10

                onClicked: {
                    if (pageStack.currentItem != root.startPage)
                        pageStack.push(root.startPage)
                }
            }
            TabButton {
                text: "Apps"
                font.pixelSize: 11
                font.weight: Font.DemiBold
                checked: pageStack.currentItem == root.appsPage

                // WORKAROUND
                padding: 0
                Component.onCompleted: padding = 10

                onClicked: {
                    if (pageStack.currentItem != root.appsPage)
                        pageStack.push(root.appsPage)
                }
            }
            TabButton {
                text: "Spiele"
                font.pixelSize: 11
                font.weight: Font.DemiBold
                checked: pageStack.currentItem == root.gamesPage

                // WORKAROUND
                padding: 0
                Component.onCompleted: padding = 10

                onClicked: {
                    if (pageStack.currentItem != root.gamesPage)
                        pageStack.push(root.gamesPage)
                }
            }
            TabButton {
                text: "Musik"
                font.pixelSize: 11
                font.weight: Font.DemiBold
                checked: pageStack.currentItem == root.musicPage

                // WORKAROUND
                padding: 0
                Component.onCompleted: padding = 10

                onClicked: {
                    if (pageStack.currentItem != root.musicPage)
                        pageStack.push(root.musicPage)
                }
            }
            TabButton {
                text: "Filme & TV"
                font.pixelSize: 11
                font.weight: Font.DemiBold
                checked: pageStack.currentItem == root.filmsPage

                // WORKAROUND
                padding: 0
                Component.onCompleted: padding = 10

                onClicked: {
                    if (pageStack.currentItem != root.filmsPage)
                        pageStack.push(root.filmsPage)
                }
            }
        }

        Button {
            anchors.right: parent.right
            text: "Back"
            onClicked: pageStack.pop()
            enabled: pageStack.depth > 1
            visible: win10TitleBar.error != ""
        }

        TitleBar {
            id: win10TitleBar
            backButtonVisible: pageStack.depth > 1
            onBackButtonPressed: pageStack.pop()

            onErrorChanged: console.log("NOTE: " + error)
        }

        SearchBox {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.margins: 2
            placeholderText: "Suchen"
            onStartSearch: console.log("now starting the search...")
        }
    }

    StackView {
        id: pageStack
        anchors.fill: parent
        initialItem: root.startPage
    }

    property StartPage startPage: StartPage { }
    property AppsPage appsPage: AppsPage { }
    property GamesPage gamesPage: GamesPage { }
    property MusicPage musicPage: MusicPage { }
    property FilmsPage filmsPage: FilmsPage { }
}
