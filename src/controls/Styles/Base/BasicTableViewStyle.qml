/****************************************************************************
**
** Copyright (C) 2015 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the Qt Quick Controls module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL3$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see http://www.qt.io/terms-conditions. For further
** information use the contact form at http://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPLv3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl.html.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 2.0 or later as published by the Free
** Software Foundation and appearing in the file LICENSE.GPL included in
** the packaging of this file. Please review the following information to
** ensure the GNU General Public License version 2.0 requirements will be
** met: http://www.gnu.org/licenses/gpl-2.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.2
import QtQuick.Controls 1.4
import QtQuick.Controls.Private 1.0

/*!
    \qmltype BasicTableViewStyle
    \inqmlmodule QtQuick.Controls.Styles
    \since 5.1
    \internal
    \qmlabstract
    \ingroup viewsstyling
    \brief Provides custom styling for TableView

    \note This class derives from \l {ScrollViewStyle}
    and supports all of the properties defined there.
*/
ScrollViewStyle {
    id: root

    /*! \internal */
    readonly property BasicTableView control: __control

    /*! The text color. */
    property color textColor: SystemPaletteSingleton.text(control.enabled)

    /*! The background color. */
    property color backgroundColor: control.backgroundVisible ? SystemPaletteSingleton.base(control.enabled) : "transparent"

    /*! The alternate background color. */
    property color alternateBackgroundColor: "#f5f5f5"

    /*! The text highlight color, used within selections. */
    property color highlightedTextColor: "white"

    /*! Activates items on single click. */
    property bool activateItemOnSingleClick: false

    padding.top: control.headerVisible ? 0 : 1

    /*! \qmlproperty Component BasicTableViewStyle::headerDelegate
    Delegate for header. This delegate is described in \l {TreeView}{TreeView.headerDelegate} and \l {TableView}{TableView.headerDelegate}
    */
    property Component headerDelegate: BorderImage {
        height: textItem.implicitHeight * 1.2
        source: "images/header.png"
        border.left: 4
        border.bottom: 2
        border.top: 2
        Text {
            id: textItem
            anchors.fill: parent
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: styleData.textAlignment
            anchors.leftMargin: 12
            text: styleData.value
            elide: Text.ElideRight
            color: textColor
            renderType: Settings.isMobile ? Text.QtRendering : Text.NativeRendering
        }
        Rectangle {
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 1
            anchors.topMargin: 1
            width: 1
            color: "#ccc"
        }
    }

    /*! \qmlproperty Component BasicTableViewStyle::rowDelegate
    Delegate for row. This delegate is described in \l {TreeView}{TreeView.rowDelegate} and \l {TableView}{TableView.rowDelegate}
    */
    property Component rowDelegate: Rectangle {
        height: Math.round(TextSingleton.implicitHeight * 1.2)
        property color selectedColor: control.activeFocus ? "#07c" : "#999"
        color: styleData.selected ? selectedColor :
                                    !styleData.alternate ? alternateBackgroundColor : backgroundColor
    }

    /*! \qmlproperty Component BasicTableViewStyle::itemDelegate
    Delegate for item. This delegate is described in \l {TreeView}{TreeView.itemDelegate} and \l {TableView}{TableView.itemDelegate}
    */
    property Component itemDelegate: Item {
        height: Math.max(16, label.implicitHeight)
        property int implicitWidth: label.implicitWidth + 20

        Text {
            id: label
            objectName: "label"
            width: parent.width - x
            x: styleData.depth && styleData.column === 0 ? 0 : 8
            horizontalAlignment: styleData.textAlignment
            anchors.verticalCenter: parent.verticalCenter
            anchors.verticalCenterOffset: 1
            elide: styleData.elideMode
            text: styleData.value !== undefined ? styleData.value : ""
            color: styleData.textColor
            renderType: Settings.isMobile ? Text.QtRendering : Text.NativeRendering
        }
    }

    /*! \internal
        Part of TreeViewStyle
    */
    property Component __branchDelegate: null

    /*! \internal
        Part of TreeViewStyle
    */
    property int __indentation: 12
}