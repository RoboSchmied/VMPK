# Virtual MIDI Piano Keyboard
# Copyright (C) 2008-2013 Pedro Lopez-Cabanillas <plcl@users.sourceforge.net>
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License along
# with this program; If not, see <http://www.gnu.org/licenses/>.

TEMPLATE = app
TARGET = vmpk
VERSION = 0.5.99 # will become 0.6 upon release
QT += core \
    gui \
    widgets \
    xml \
    svg

dbus {
    DEFINES += ENABLE_DBUS
    CONFIG += qdbus
    QT += dbus
    DBUS_ADAPTORS += src/net.sourceforge.vmpk.xml
}

DEFINES += NETWORK_MIDI
QT += network

lessThan(QT_MAJOR_VERSION, 5) {
    message("Cannot build VMPK with Qt $${QT_VERSION}")
    error("Use Qt 5.0 or newer")
}

# greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

DEFINES += VERSION=$$VERSION

win32 {
    DEFINES += __WINDOWS_MM__
    LIBS += -lwinmm
    LIBS += -lws2_32
    RC_FILE = src/vpianoico.rc
    DEFINES += RAWKBD_SUPPORT
}

linux* {
    QT += gui-private
    DEFINES += __LINUX_ALSASEQ__
    DEFINES += AVOID_TIMESTAMPING
    DEFINES += RAWKBD_SUPPORT
    CONFIG += link_pkgconfig
    PKGCONFIG += xcb alsa
    LIBS += -lpthread
    jack_midi {
        PKGCONFIG += jack
        DEFINES += __LINUX_JACK__
    }
}

macx {
    #CONFIG += x86
    ICON = data/vmpk.icns
    DEFINES += __MACOSX_CORE__
    DEFINES += RAWKBD_SUPPORT
    BUNDLE_RES.files = data/help.html \
        data/help_de.html \
        data/help_es.html \
        data/help_fr.html \
        data/help_nl.html \
        data/help_ru.html \
        data/gmgsxg.ins \
        data/spanish.xml \
        data/german.xml \
        data/azerty.xml \
        data/it-qwerty.xml \
        data/vkeybd-default.xml \
        data/pc102mac.xml \
        #qt.conf \
        $$[QT_INSTALL_TRANSLATIONS]/qt_cs.qm \
        $$[QT_INSTALL_TRANSLATIONS]/qt_de.qm \
        $$[QT_INSTALL_TRANSLATIONS]/qt_es.qm \
        $$[QT_INSTALL_TRANSLATIONS]/qt_fr.qm \
        $$[QT_INSTALL_TRANSLATIONS]/qt_gl.qm \
        $$[QT_INSTALL_TRANSLATIONS]/qt_ru.qm \
        $$[QT_INSTALL_TRANSLATIONS]/qt_sv.qm \
        #$$[QT_INSTALL_TRANSLATIONS]/qt_zh_CN.qm \
        vmpk_cs.qm \
        vmpk_de.qm \
        vmpk_es.qm \
        vmpk_fr.qm \
        vmpk_gl.qm \
        #vmpk_nl.qm \
        vmpk_ru.qm \
        vmpk_sr.qm \
        vmpk_sv.qm
        #vmpk_zh_CN.qm
    BUNDLE_RES.path = Contents/Resources
    QMAKE_BUNDLE_DATA += BUNDLE_RES
    LIBS += -framework CoreMidi \
        -framework CoreAudio \
        -framework CoreFoundation \
        -framework Cocoa
}
irix* {
    CONFIG += x11
    DEFINES += __IRIX_MD__
    DEFINES += RAWKBD_SUPPORT
    LIBS += -laudio \
        -lpthread
}
debug:DEFINES += __RTMIDI_DEBUG__
INCLUDEPATH += src

FORMS += src/about.ui \
    src/colordialog.ui \
    src/extracontrols.ui \
    src/midisetup.ui \
    src/preferences.ui \
    src/riffimportdlg.ui \
    src/vpiano.ui

HEADERS += src/about.h \
    src/classicstyle.h \
    src/colordialog.h \
    src/colorwidget.h \
    src/constants.h \
    src/events.h \
    src/extracontrols.h \
    src/instrument.h \
    src/keyboardmap.h \
    src/keylabel.h \
    src/knob.h \
    src/mididefs.h \
    src/midisetup.h \
    src/netsettings.h \
    src/pianodefs.h \
    src/pianokeybd.h \
    src/pianokey.h \
    src/pianopalette.h \
    src/pianoscene.h \
    src/preferences.h \
    src/nativefilter.h \
    src/riff.h \
    src/riffimportdlg.h \
    src/RtError.h \
    src/RtMidi.h \
    src/udpmidi.h \
    src/vpiano.h \
    src/maceventhelper.h

SOURCES += src/about.cpp \
    src/classicstyle.cpp \
    src/colordialog.cpp \
    src/colorwidget.cpp \
    src/extracontrols.cpp \
    src/instrument.cpp \
    src/keyboardmap.cpp \
    src/keylabel.cpp \
    src/knob.cpp \
    src/main.cpp \
    src/midisetup.cpp \
    src/pianokeybd.cpp \
    src/pianokey.cpp \
    src/pianopalette.cpp \
    src/pianoscene.cpp \
    src/preferences.cpp \
    src/riff.cpp \
    src/riffimportdlg.cpp \
    src/RtMidi.cpp \
    src/udpmidi.cpp \
    src/vpiano.cpp

FORMS += src/kmapdialog.ui \
    src/shortcutdialog.ui
HEADERS += src/kmapdialog.h \
    src/shortcutdialog.h
SOURCES += src/kmapdialog.cpp \
    src/shortcutdialog.cpp \
    src/nativefilter.cpp

macx {
    OBJECTIVE_SOURCES += \
        src/maceventhelper.mm
}

RESOURCES += data/vmpk.qrc

TRANSLATIONS +=  translations/vmpk_cs.ts \
    translations/vmpk_de.ts \
    translations/vmpk_es.ts \
    translations/vmpk_fr.ts \
    translations/vmpk_gl.ts \
    #translations/vmpk_nl.ts \
    translations/vmpk_ru.ts \
    translations/vmpk_sr.ts \
    translations/vmpk_sv.ts
    #translations/vmpk_zh_CN.ts

include(updateqm.pri)
