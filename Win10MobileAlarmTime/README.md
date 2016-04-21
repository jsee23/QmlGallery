# Win10MobileAlarmTime
The goal of this app is to demonstrate how to create a Windows 10 Mobile Qt/QML-app, with a native look-and-feel.

Therefore, the Qt Labs Control QML-module is massivly used (NOTE: with Qt >= 5.7, this module will be renamed to Qt Quick Controls 2).
It expends the control set of QtLC with the following, Windows 10 specific, controls:
* AppBar
* AppBarButton
* AppBarItemDelegate
* AppBarSecondaryCommand
* IconTabBar
* IconTabButton

NOTE: To re-use this controls in more apps, creating a QML module for it would be the way to go.
If you like my work, feel free to contact me, I will create a module for you!

## Requirements
* Qt 5.6.x 

## Controls
### AppBar
The AppBar is widely used on Windows 10 Mobile and also known on the desktop.
It's placed on the bottom of a page and consist of the AppBar itself, AppBarButtons with an icon and text and optional SecondaryCommands.
These SecondaryCommands normally have a text and are placed in a kind-of popup menu.
```QML
import QtQuick 2.6
import Qt.labs.controls 1.0

Page {
    ...
    footer: AppBar {
	    id: appbar
		
		Row {
		    anchors.right: parent.right
			anchors.rightMargin: 64

            AppBarButton {
                text: "Add"
                icon: "\ue710"
            }
            AppBarButton {
                text: "List"
                icon: "\ue133"
            }
		}
		
		secondaryCommands: [
		    AppBarSecondaryCommand { text: "Send feedback" },
		    AppBarSecondaryCommand { text: "Info" }
		]
		
		itemDelegate: AppBarItemDelegate {
		    width: appbar.width
			tet: modelData.text
		}
	}
}
```
With the `itemDelegate` proeprty, you can easily modify the look of the SecondaryCommand items. 

### IconTabBar
The IconTabBar is somehow a new control, which is the successor of the classic and well-known Pivot of Windows Phone.
It's used in various customizations, the version of this app is just "copying" the style how it is used in the Windows 10 Mobile app "Alarms and Time".
```QML
import QtQuick 2.6
import Qt.labs.controls 1.0

Page {
    ...
    header: IconTabBar {
	    ...
		IconTabButton {
		    text: "Alarms"
			iconSource: checked ? "qrc:/img/alarms_checked.png" : "qrc:/img/alarms.png"
		}
		
		IconTabButton {
		    text: "Stopwatch"
			icon: "\ue916"
		}
	}
}
```

### AppBarButtonm, IconTabButton & Segoe MDL2 Assets
Both the AppBarButton and the IconTabButton can use the feature set of the Windows 10 font Segoe MDL2 Assets.
Just use the `icon` property of both controls as shown above.