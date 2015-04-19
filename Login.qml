import QtQuick 2.3
import QtQuick.Controls 1.2
import Qt.labs.settings 1.0

Item{
    Column{
        anchors.horizontalCenter:parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 100
        TextField{
            id: usernameInput
            placeholderText: "Username"
            //anchors.horizontalCenter:parent.horizontalCenter

        }
        TextField{
            id: passwordInput
            placeholderText: "Passwort"
            //anchors.horizontalCenter:parent.horizontalCenter
            echoMode: TextInput.Password
        }
        Button{
            text: "Save"
            //anchors.horizontalCenter:parent.horizontalCenter
            onClicked: {
                settings.username = usernameInput.text
                settings.password = passwordInput.text
                stackView.push(Qt.resolvedUrl("Plan.qml"))
            }
        }
    }
}

