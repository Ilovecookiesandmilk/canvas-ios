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
import TestsFoundation

class LoginTests: CoreUITestCase {
    override var abstractTestClass: CoreUITestCase.Type { return LoginTests.self }
    override var user: UITestUser? { return nil }

    func testFindSchool() {
        XCTAssertEqual(LoginStart.findSchoolButton.label(), "Find my school")
        LoginStart.findSchoolButton.tap()
        LoginFindSchool.searchField.typeText("mtech")
        LoginFindAccountResult.item(host: "mtec.instructure.com").waitToExist()
    }

    func testCanvasLoginToDashboard() {
        logInUser(.readStudent1)

        Dashboard.coursesLabel.waitToExist()
        Dashboard.courseCard(id: "247").waitToExist()
        XCTAssert(TabBar.dashboardTab.exists)
    }

    // TODO: Get new LDAP account
    func xtestLDAPLoginToDashboard() {
        let user = UITestUser.ldapUser
        LoginStart.findSchoolButton.tap()
        LoginFindSchool.searchField.typeText("\(user.host)\r")

        XCUIElementWrapper(app.webViews.links["LDAP"]).tap()

        LoginWeb.emailField.typeText(user.username)
        LoginWeb.passwordField.typeText(user.password)
        LoginWeb.logInButton.tap()

        Dashboard.coursesLabel.waitToExist()
        TabBar.dashboardTab.waitToExist()
    }

    func testSAMLLoginToDashboard() {
        setAnimationsEnabled(true)
        let user = UITestUser.saml
        LoginStart.findSchoolButton.tap()
        LoginFindSchool.searchField.typeText("\(user.host)")
        LoginFindAccountResult.item(host: "iosauto.instructure.com").tap()
        LoginWeb.emailField.typeText(" \r")
        LoginWeb.emailField.typeText("\(user.username)\r")
        LoginWeb.passwordField.tap()
        LoginWeb.passwordField.typeText(" \r")
        LoginWeb.passwordField.tap()
        LoginWeb.passwordField.typeText("\(user.password)\r")
        TabBar.dashboardTab.waitToExist()
    }

    func testMultipleUsers() {
        logInUser(.readStudent1)
        let entry1 = UITestUser.readStudent1.session!

        Profile.open()
        Profile.changeUserButton.tap()

        logInUser(.readStudent2)
        let entry2 = UITestUser.readStudent2.session!

        Profile.open()
        Profile.changeUserButton.tap()

        LoginStart.findSchoolButton.waitToExist()
        XCTAssert(LoginStartSession.cell(host: entry1.baseURL.host!, userID: entry1.userID).exists)
        XCTAssert(LoginStartSession.cell(host: entry2.baseURL.host!, userID: entry2.userID).exists)
    }

    func testSessionMaintainedAfterTermination() {
        logInUser(.readStudent1)

        Dashboard.coursesLabel.waitToExist()
        Dashboard.courseCard(id: "247").waitToExist()
        TabBar.dashboardTab.waitToExist()

        Dashboard.coursesLabel.waitToExist()
        Dashboard.courseCard(id: "247").waitToExist()
        TabBar.dashboardTab.waitToExist()
    }

    func testMDMLogin() {
        let user = UITestUser.readStudent1
        launch { app in
            app.launchArguments.append(contentsOf: [
                "-com.apple.configuration.managed",
                user.profile,
            ])
        }

        LoginStartMDMLogin.cell(host: user.host, username: user.username).tap()

        Dashboard.coursesLabel.waitToExist()
        Dashboard.courseCard(id: "247").waitToExist()
        TabBar.dashboardTab.waitToExist()

        launch()
    }

    func xtestMDMHost() {
        let user = UITestUser.readStudent1
        launch { app in
            app.launchArguments.append(contentsOf: [
                "-com.apple.configuration.managed",
                """
                    <dict>
                        <key>enableLogin</key><true/>
                        <key>host</key><string>\(user.host)</string>
                    </dict>
                """
                .replacingOccurrences(of: "[\\n\\s]", with: "", options: .regularExpression, range: nil),
            ])
        }

        LoginStart.findSchoolButton.waitToExist()
        XCTAssertEqual(LoginStart.findSchoolButton.label(), "Log In")
        XCTAssertFalse(LoginStart.canvasNetworkButton.isVisible)
        LoginStart.findSchoolButton.tap()

        LoginWeb.emailField.typeText(user.username)
        LoginWeb.passwordField.typeText(user.password)
        LoginWeb.logInButton.tap()

        homeScreen.waitToExist()

        launch()
    }
}
