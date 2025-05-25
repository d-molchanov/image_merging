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

	ColumnLayout {
		anchors.fill: parent
		spacing: 10


		Button {
			id: btnSelectDirectory
			text: qsTr("Select directory")
			onClicked: folderDialog.open()
		}

		FolderDialog {
			id: folderDialog
			currentFolder: "."
		}

		Label {
			text: qsTr("Suffixes")
		}

		ScrollView {
			
			id: scvSuffices

			TextArea {
				id: tarSuffices
			    placeholderText: qsTr("Enter suffices")
			}

		}
	}

}