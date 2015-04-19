import QtQuick 2.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2
import QtQuick.Dialogs 1.2
import QtGraphicalEffects 1.0
import QtQuick.Layouts 1.1
import QtQuick.Controls.Styles 1.1
import Qt.labs.settings 1.0
//import PyOtherSide for Android
import io.thp.pyotherside 1.4

ApplicationWindow {
    id: appWindow
    visible: true
    //property alias date: actionText.text
    //Action Bar at the top of the screen needs to be dynamically named
    toolBar: ToolBar{
        Text{
            id: actionText
            font.pixelSize: 36
            anchors.left: parent.left
            anchors.leftMargin: 20
            anchors.verticalCenter: parent.verticalCenter
        }
    }

    menuBar: MenuBar {
        id: topMenu

        Menu {
            title: "Test"
            MenuItem {
                text: qsTr("&About")
                onTriggered: messageDialog.show("Von Tim-Leon Klocke \n thanks to thp for PyOtherside and the Qt Project");
            }

        }
    }

    MessageDialog {
        id: messageDialog
        title: "About"

        function show(caption) {
            messageDialog.text = caption;
            messageDialog.open();
        }
    }
    Settings{
        id: settings
        property string username
        property string password
    }
    StackView {
        id: stackView
        anchors.fill: parent
        // Implements back key navigation
        focus: true
        Keys.onReleased: if (event.key === Qt.Key_Back && stackView.depth > 1) {
                             stackView.pop();
                             event.accepted = true;
                         }

        initialItem: if (settings.username != ""){ Qt.resolvedUrl("Plan.qml") } else { Qt.resolvedUrl("Login.qml") }
    }
 }
