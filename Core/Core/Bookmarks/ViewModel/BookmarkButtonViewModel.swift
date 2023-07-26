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

import Combine

class BookmarkButtonViewModel: ObservableObject {
    @Published public var isShowingConfirmationDialog = false
    @Published public var isBookmarked = false
    public private(set) var confirmDialog: ConfirmationAlertViewModel
    private let confirmAddDialog = ConfirmationAlertViewModel(
        title: NSLocalizedString("Add Bookmark?", comment: ""),
        message: NSLocalizedString(
            """
            After you have added a bookmark you can access it from the bookmarks menu or \
            by long pressing on the application's icon on your device's home screen. Only \
            the top four bookmarks are accessible this way.
            """, comment: ""),
        cancelButtonTitle: NSLocalizedString("Cancel", comment: ""),
        confirmButtonTitle: NSLocalizedString("OK", comment: ""),
        isDestructive: false
    )
    private let confirmDeleteDialog = ConfirmationAlertViewModel(
        title: NSLocalizedString("Delete Bookmark?", comment: ""),
        message: NSLocalizedString(
            """
            This screen is already bookmarked. Do you want to delete the bookmark for this screen?
            """, comment: ""),
        cancelButtonTitle: NSLocalizedString("Cancel", comment: ""),
        confirmButtonTitle: NSLocalizedString("Delete", comment: ""),
        isDestructive: true
    )
    private let bookmarksInteractor: BookmarksInteractor
    private let title: String
    private let route: String
    private var existingBookmarkId: String?

    public init(bookmarksInteractor: BookmarksInteractor,
                title: String,
                route: String) {
        self.bookmarksInteractor = bookmarksInteractor
        self.title = title
        self.route = route
        self.confirmDialog = confirmAddDialog
        bookmarksInteractor
            .getBookmark(for: route)
            .handleEvents(receiveOutput: { [weak self] bookmark in
                self?.existingBookmarkId = bookmark?.id
            })
            .map { $0 != nil }
            .assign(to: &$isBookmarked)
    }

    public func bookmarkButtonDidTap() {
        if isBookmarked {
            guard let existingBookmarkId else { return }
            confirmDialog = confirmDeleteDialog
            confirmDeleteDialog
                .userConfirmation()
                .flatMap { [bookmarksInteractor] in
                    bookmarksInteractor
                        .deleteBookmark(id: existingBookmarkId)
                }
                .handleEvents(receiveOutput: { [weak self] _ in
                    self?.existingBookmarkId = nil
                })
                .mapToValue(false)
                .replaceError(with: true)
                .assign(to: &$isBookmarked)
        } else {
            confirmDialog = confirmAddDialog
            confirmAddDialog
                .userConfirmation()
                .flatMap { [bookmarksInteractor, title, route] in
                    bookmarksInteractor
                        .addBookmark(title: title, route: route)
                }
                .handleEvents(receiveOutput: { [weak self] bookmarkId in
                    self?.existingBookmarkId = bookmarkId
                })
                .mapToValue(true)
                .replaceError(with: false)
                .assign(to: &$isBookmarked)
        }

        isShowingConfirmationDialog = true
    }
}
