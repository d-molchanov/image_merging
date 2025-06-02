import QtCore
import QtQuick
import QtQuick.Window
import QtQuick.Controls
import QtQuick.Dialogs
import QtQuick.Layouts

Window {
    width: 640
    height: 480
    visible: true
    title: qsTr("Image Merger ver. 0.1")

    color: systemPalette.window
    SystemPalette {
        id: systemPalette
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 10

        Label {
                text: qsTr("Logs:")
                color: systemPalette.windowText
        }

        Item {
            Layout.fillWidth: true

            ScrollView {
                id: scvSuffices
                width: parent.width
                height: 50
                ScrollBar.vertical.policy: ScrollBar.AsNeeded
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                
                TextArea {
                    id: tarSuffices
                    width: parent.width
                    height: parent.height
                    wrapMode: TextEdit.Wrap

                    placeholderText: qsTr("This is logs")
                    
                }

            }
        }

        Item {
            Layout.fillHeight: true
        }

    }

    // Button {
    //     id: btnSelectDirectory
    //     Layout.alignment: Qt.AlignCenter
    //     text: qsTr("Select directory")
    //     onClicked: folderDialog.open()
    //     hoverEnabled: true
    //     ToolTip.delay: 1000
    //     ToolTip.timeout: 5000
    //     ToolTip.visible: hovered
    //     ToolTip.text: qsTr("Select directory")
    // }

    // FolderDialog {
    //     id: folderDialog
    //     currentFolder: "."
    // }


    // Label {
    //     id: lblSuffixes
    //     // anchors.top: btnSelectDirectory.botton
    //     text: qsTr("Suffixes")

    // }


    // ScrollView {
    // //Works fine without layouts
    //     id: scvSuffices
    //     width: parent.width
    //     height: 50
    //     TextArea {
    //         id: tarSuffices
    //         width: parent.width
    //         height: parent.height
    //         placeholderText: qsTr("Enter suffices")
            
    //     }

    // }

    // Label {
    //     text: qsTr("Logs:")
    // }

    // ScrollView {
    //     // Also works fine without layouts
    //     // Layout.fillWidth: true
    //     ScrollBar.vertical.policy: ScrollBar.AsNeeded
    //     width: parent.width

    //     height: 50
    //     clip: true
    //     contentHeight: tarLogs.height
        
    //     TextArea {
    //         id: tarLogs
    //         height: 50
    //         wrapMode: TextEdit.Wrap
    //     }

    // }

    // Label {
    //     text: qsTr("Flicable")
    // }

    // Flickable {
    //     // Does not work at all
    //     width: parent.width
    //     // Layout.fillWidth: true
    //     height: 50 // Высота видимой области
    //     clip: true
    //     flickableDirection: Flickable.VerticalFlick // Только вертикальная прокрутка
    //     contentHeight: textArea.paintedHeight      // Высота контента - это paintedHeight TextArea
    //     contentWidth: textArea.paintedWidth // Ширина контента - это paintedWidth TextArea


    //     ScrollBar.vertical: ScrollBar { policy: ScrollBar.AsNeeded } // Полоса прокрутки по мере необходимости
    //     ScrollBar.horizontal: null                               // Отключаем горизонтальную прокрутку

    //     TextArea {
    //         id: textArea
    //         width: parent.width                 // TextArea занимает всю ширину родителя
    //         wrapMode: TextArea.WordWrap
    //         textFormat: Text.RichText // Для корректной работы paintedHeight с переносом строк
    //         onTextChanged: {
    //             flickableItem.contentX = 0; // Сбрасываем горизонтальную прокрутку
    //             }

    //         }
    //     }
    }
