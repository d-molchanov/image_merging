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

        Button {
            id: btnSelectDirectory
            Layout.alignment: Qt.AlignHCenter
            text: qsTr("Select directory")
            onClicked: folderDialog.open()
            hoverEnabled: true
            ToolTip.delay: 1000
            ToolTip.timeout: 5000
            ToolTip.visible: hovered
            ToolTip.text: qsTr("Select directory")
        }

        FolderDialog {
            id: folderDialog
            currentFolder: "."
        }

        Item {
        // Rectangle {
            // anchors.fill: parent
            // color: "#ff0000"
            Layout.fillWidth: true
            // Layout.alignment: Qt.AlignHCenter
            RowLayout {
            Layout.fillWidth: true

                anchors.fill: parent

                // spacing: 10

                ColumnLayout{
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                    Label {
                        id: lblSuffixes
                        Layout.fillWidth: true

                        text: qsTr("Suffixes")
                        color: systemPalette.windowText
                        Layout.alignment: Qt.AlignHCenter

                        // Layout.alignment: Qt.AlignLeft
                    }
                }

                ColumnLayout{
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignHCenter
                    Label {
                        Layout.fillWidth: true
                        id: lblExtensions
                        text: qsTr("Extensions")
                        color: systemPalette.windowText
                        Layout.alignment: Qt.AlignHCenter
                        // Layout.alignment: Qt.AlignRight

                    }
                }

            }
        }

        Label {
                text: qsTr("Logs:")
                color: systemPalette.windowText
        }

        Item {
            Layout.fillWidth: true
            Layout.minimumHeight: 50
            Layout.preferredHeight: 50
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

            Layout.fillWidth: true
            Layout.leftMargin: 10

            Layout.minimumHeight: 140
            // Layout.preferredHeight: 50
            // Layout.alignment: Qt.AlignHCenter
            RowLayout {
            // Layout.fillWidth: true
                id: rwLt
                anchors.fill: parent
                spacing: 0
                // spacing: 10

                ColumnLayout{
                    Layout.fillWidth: true
                    spacing: 0
                    // Layout.alignment: Qt.AlignHCenter
                    Item {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 20
                        Label {
                            text: qsTr("Suffixes")
                            color: systemPalette.windowText
                            anchors.centerIn: parent

                        }
                    }

                    Item {
                        Layout.fillWidth: true
                        Layout.minimumHeight: 100
                        Layout.preferredHeight: 100
                        ScrollView {
                            id: scvSufficesNew
                            width: parent.width
                            height: 100
                            ScrollBar.vertical.policy: ScrollBar.AsNeeded
                            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                            
                            TextArea {
                                id: tarSufficesNew
                                width: parent.width
                                height: parent.height
                                wrapMode: TextEdit.Wrap

                                placeholderText: qsTr("This is Suffixes")
                                
                            }

                        }
                    }

                    Item {
                        Layout.fillHeight: true
                    }

                }

                Item {
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    // Layout.alignment: Qt.AlignHCenter
                    
                    GroupBox {
                        anchors.fill: parent
                        // Layout.preferredWidth: rwLt.width / 2
                        title: qsTr("Extensions")
                        ScrollView {
                            id: scvExtensionsNew
                            width: parent.width
                            height: 100
                            ScrollBar.vertical.policy: ScrollBar.AsNeeded
                            ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                            
                            TextArea {
                                id: tarExtensionsNew
                                width: parent.width
                                height: parent.height
                                wrapMode: TextEdit.Wrap

                                placeholderText: qsTr("This is Extensions")
                                        
                            }
                        }
                    }
                }
            }



    
        }
        Item {
            Layout.fillHeight: true
        }

    }
        // Item {
        //     Layout.fillWidth: true

        //     RowLayout {
        //         id: layout
        //         anchors.fill: parent
        //         spacing: 6
        //         Rectangle {
        //             color: 'teal'
        //             // Layout.fillWidth: true
        //             Layout.minimumWidth: 50
        //             Layout.preferredWidth: 100
        //             // Layout.maximumWidth: 300
        //             Layout.minimumHeight: 150
        //             Layout.alignment: Qt.AlignHCenter
        //             Text {
        //                 anchors.centerIn: parent
        //                 text: parent.width + 'x' + parent.height
        //             }
        //         }
        //         Rectangle {
        //             color: 'plum'
        //             // Layout.fillWidth: true
        //             Layout.minimumWidth: 100
        //             Layout.preferredWidth: 200
        //             Layout.preferredHeight: 100
        //             Layout.alignment: Qt.AlignHCenter
        //             Text {
        //                 anchors.centerIn: parent
        //                 text: parent.width + 'x' + parent.height
        //             }
        //         }
        //     }

        // }


        // Item {

        //     Layout.fillWidth: true
        //     Layout.minimumHeight: 50
        //     Layout.preferredHeight: 50
        //     // Layout.alignment: Qt.AlignHCenter
        //     RowLayout {
        //     // Layout.fillWidth: true

        //         anchors.fill: parent
        //         spacing: 0
        //         // spacing: 10

        //         ColumnLayout{
        //             Layout.fillWidth: true
        //             Layout.alignment: Qt.AlignHCenter
        //             Rectangle {

        //                 // Layout.preferredWidth: 100
        //                 Layout.fillWidth: true
        //                 Layout.preferredHeight: 50
        //                 color: "#ff0000"
        //             }
                    
        //         }

        //         ColumnLayout{
        //             Layout.fillWidth: true
        //             Layout.alignment: Qt.AlignHCenter
        //             Rectangle {
                        
        //                 Layout.fillWidth: true
        //                 // Layout.preferredWidth: 100
        //                 Layout.preferredHeight: 50
        //                 color: "#00ff00"
        //             }
        //         }

        //     }
        // }

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
