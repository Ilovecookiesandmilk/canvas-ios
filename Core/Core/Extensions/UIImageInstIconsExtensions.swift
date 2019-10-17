//
// This file is part of Canvas.
// Copyright (C) 2019-present  Instructure, Inc.
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

// DO NOT EDIT: this file was generated by build-icons.js

import Foundation

extension UIImage {
    public enum InstIconType: String {
        case line = "Line"
        case solid = "Solid"
    }

    public enum InstIconName: String, CaseIterable {
        case add, alerts, announcement, arrowOpenLeft, arrowOpenRight, assignment, audio, bold, box,
            bulletList, calendarMonth, check, cloudLock, complete, courses, dashboard, discussion,
            document, email, empty, eye, folder, forward, gradebook, group, hamburger, highlighter,
            image, instructure, italic, link, lock, lti, marker, miniArrowDown, miniArrowUp, module,
            more, no, numberedList, outcomes, paint, paperclip, pause, pdf, play, prerequisite,
            publish, question, quiz, refresh, reply, rubric, settings, star, strikethrough, text,
            textColor, trash, trouble, unlock, user, video, warning, x
    }

    public static func icon(_ name: InstIconName, _ type: InstIconType = .line) -> UIImage {
        let named = name.rawValue + type.rawValue
        return UIImage(named: named, in: .core, compatibleWith: nil)!
    }
}
