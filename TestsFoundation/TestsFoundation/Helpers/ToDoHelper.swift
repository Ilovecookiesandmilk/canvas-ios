//
// This file is part of Canvas.
// Copyright (C) 2023-present  Instructure, Inc.
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as
// published by the Free Software Foundation, either version 3 of the
// License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.
//

public class ToDoHelper: BaseHelper {
    public static var navBar: XCUIElement { app.find(type: .navigationBar) }
    public static var toDoBackButton: XCUIElement { navBar.find(label: "To Do", type: .button) }

    public static func cell(id: String) -> XCUIElement {
        return app.find(id: "to-do.list.\(id).row")
    }

    public static func cellItemTitle(cell itemCell: XCUIElement) -> XCUIElement {
        return itemCell.find(type: .staticText)
    }
}
