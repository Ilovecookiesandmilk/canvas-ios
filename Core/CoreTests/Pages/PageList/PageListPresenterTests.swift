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

import XCTest
@testable import Core
import TestsFoundation

class PageListPresenterTests: CoreTestCase {

    var resultingError: NSError?
    var resultingSubtitle: String?
    var resultingBackgroundColor: UIColor?
    var coursePresenter: PageListPresenter!
    var groupPresenter: PageListPresenter!

    let update = XCTestExpectation(description: "presenter updated")
    var onUpdateNavBar: ((String?, UIColor?) -> Void)?
    var updateExpectationPredicate: () -> Bool = { return true }

    var color: UIColor?
    var navigationController: UINavigationController?
    var titleSubtitleView = TitleSubtitleView.create()
    var navigationItem: UINavigationItem = UINavigationItem(title: "")

    override func setUp() {
        super.setUp()
        coursePresenter = PageListPresenter(env: environment, view: self, context: ContextModel(.course, id: "42"))
        groupPresenter = PageListPresenter(env: environment, view: self, context: ContextModel(.group, id: "42"))
    }

    func testLoadGroup() {
        XCTAssertNil(resultingSubtitle)
        XCTAssertNil(resultingBackgroundColor)

        let g = Group.make(from: .make(id: "42"), in: databaseClient)
        ContextColor.make(canvasContextID: g.canvasContextID, color: UIColor.red)

        let expectation = self.expectation(description: "navbar")
        expectation.assertForOverFulfill = false
        onUpdateNavBar = {
            if $0 == g.name && $1 == g.color { expectation.fulfill() }
        }
        groupPresenter.viewIsReady()

        wait(for: [expectation], timeout: 5)
    }

    func testLoadCourse() {
        XCTAssertNil(resultingSubtitle)
        XCTAssertNil(resultingBackgroundColor)

        let c = Course.make(from: .make(id: "42"), in: databaseClient)
        ContextColor.make(canvasContextID: c.canvasContextID, color: UIColor.red)

        let expectation = self.expectation(description: "navbar")
        expectation.assertForOverFulfill = false
        onUpdateNavBar = {
            if $0 == c.name && $1 == c.color { expectation.fulfill() }
        }
        coursePresenter.viewIsReady()

        wait(for: [expectation], timeout: 5)
    }

    func testLoadPages() {
        api.mock(GetPagesRequest(context: ContextModel(.course, id: "42")), value: [.make(title: "Answers Page")])
        updateExpectationPredicate = { self.coursePresenter.pages.first?.title == "Answers Page" }
        coursePresenter.viewIsReady()
        wait(for: [update], timeout: 1)
    }

    func testLoadFrontPage() {
        api.mock(GetFrontPageRequest(context: ContextModel(.course, id: "42")), value: .make(front_page: true, title: "Front Page"))
        updateExpectationPredicate = { self.coursePresenter.frontPage.first?.title == "Front Page" }
        coursePresenter.viewIsReady()
        wait(for: [update], timeout: 1)
        XCTAssertEqual(coursePresenter.frontPage.first?.title, "Front Page")
        XCTAssertEqual(coursePresenter.frontPage.first?.isFrontPage, true)
    }

    func testSelect() {
        let page = Page.make()
        let router = environment.router as? TestRouter
        XCTAssertNoThrow(coursePresenter.select(page, from: UIViewController()))
        XCTAssertEqual(router?.calls.last?.0, URLComponents.parse(page.htmlURL))
        XCTAssertEqual(router?.calls.last?.2, [.detail, .embedInNav])
    }

    func testPageViewEventName() {
        XCTAssertEqual(coursePresenter.pageViewEventName, "courses/42/pages")
    }
}

extension PageListPresenterTests: PageListViewProtocol {

    func update(isLoading: Bool) {
        if (updateExpectationPredicate()) {
            update.fulfill()
        }
    }

    func showError(_ error: Error) {
        resultingError = error as NSError
    }

    func updateNavBar(subtitle: String?, color: UIColor?) {
        resultingBackgroundColor = color
        resultingSubtitle = subtitle
        onUpdateNavBar?(subtitle, color)
    }
}
