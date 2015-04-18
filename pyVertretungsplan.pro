TEMPLATE = app

QT += qml quick widgets

SOURCES += main.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Default rules for deployment.
include(deployment.pri)

DISTFILES += \
    listmodel.py \
    material/ActionBar.qml \
    material/Card.qml \
    material/Dialog.qml \
    material/FlatButton.qml \
    material/FloatingActionButton.qml \
    material/IconButton.qml \
    material/Label.qml \
    material/Menu.qml \
    material/MenuItem.qml \
    material/MenuItemSeparator.qml \
    material/PaperRipple.qml \
    material/PaperShadow.qml \
    material/Popup.qml \
    material/RaisedButton.qml \
    material/UIConstants.qml \
    material/qmldir \
    material/RefreshButton.qml \
    assets/lawyer_cat.jpg \
    assets/icon_add.svg \
    assets/icon_back.svg \
    assets/icon_camera.svg \
    assets/icon_comment.svg \
    assets/icon_location-colored.svg \
    assets/icon_location.svg \
    assets/icon_menu.svg \
    assets/icon_refresh.svg \
    assets/icon_send-colored.svg \
    assets/icon_send.svg \
    assets/LICENSE.md
