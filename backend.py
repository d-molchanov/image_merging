from pathlib import Path
from image_merging import ImageMerger, Filepath, Alignment, Direction

from PySide6.QtCore import Signal, QObject, Slot, Property


class Backend(QObject):
    textChanged = Signal(str)
    suffixesChanged = Signal(str)
    extensionsChanged = Signal(str)
    logsUpdated = Signal(str)

    def __init__(self, parent=None):
        QObject.__init__(self, parent)
        self.image_merger = ImageMerger()
        self._text = ''
        self._suffixes = []
        self._extensions = []
        self._target_directory = ''
        self._direction = ''
        self._alignment = ''
        self._color = '#ffffff'

    @Slot()
    def merge_images(self):
        self.image_merger.process_directory(
            self._target_directory,
            self._extensions,
            self._suffixes,
            direction=self._direction,
            alignment=self._alignment,
            color=self._color,
            result_extension='.jpg'
        )

    @Property(str, notify=textChanged)
    def text(self):
        return self._text

    @text.setter
    # @Slot(str)
    def text(self, value):
        if self._text == value:
            return
        self._text = value
        self.textChanged.emit(self._text)
        print(self._text)

    @Slot(str)
    def print_text(self, value):
        print(f'Value from QML: {value}')

    @Slot(str)
    def get_suffixes(self, input_text: str) -> None:
        self._suffixes = [el for el in input_text.split() if el]
        print(f'Suffixes: {self._suffixes}')
        self.logsUpdated.emit(f'Suffixes: {self._suffixes}')
        # print(input_text)

    @Slot(str)
    def get_extensions(self, input_text: str) -> None:
        self._extensions = [el for el in input_text.split() if el]
        print(f'Extensions: {self._extensions}')
        self.logsUpdated.emit(f'Extensions: {self._extensions}')

    @Slot(str)
    def get_target_directory(self, input_text: str) -> None:
        self._target_directory = Path(input_text)
        self.logsUpdated.emit(f'Target directory: {self._target_directory}')

    @Slot(str)
    def get_direction(self, input_text: str) -> None:
        if input_text == 'Vertical':
            self._direction = Direction.VERTICAL
        elif input_text == 'Horizontal':
            self._direction = Direction.HORIZONTAL
        else:
            self._direction = ''
        self.logsUpdated.emit(f'Images direction: {self._direction} - {input_text}')

    @Slot(str)
    def get_alignment(self, input_text: str) -> None:
        if input_text == 'Center':
            self._alignment = Alignment.CENTER
        elif input_text == 'Top':
            self._alignment = Alignment.TOP
        elif input_text == 'Bottom':
            self._alignment = Alignment.BOTTOM
        elif input_text == 'Left':
            self._alignment = Alignment.LEFT
        elif input_text == 'Right':
            self._alignment = Alignment.RIGHT
        else:
            # TODO: exception to handle
            self._alignment = ''
        self.logsUpdated.emit(f'Images alignment: {self._alignment} - {input_text}')

