import sys
from PySide6.QtGui import QGuiApplication
from PySide6.QtQml import QQmlApplicationEngine
from PySide6.QtCore import QUrl, Signal, QObject, Slot, Property

from backend import Backend


if __name__ == '__main__':
    backend = Backend()

    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()
    engine.rootContext().setContextProperty("backend", backend)
    # engine.load(QUrl("main.qml"))
    engine.load(QUrl("test.qml"))
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec())