//
// Copyright (C) 2016-present Instructure, Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

import Foundation
import XCTest
import CanvasKeymaster
import EarlGrey
import SoSeedySwift
@testable import CanvasCore // for NativeLoginManager

class TeacherTestUtils {
    // All tokens are generated by SoSeedy at the same time.
    // Validating only the first token is sufficient.
    private static var tokenValidated:Bool = false

    static func getUserLoginInfo2(_ canvasUser:Soseedy_CanvasUser) -> [String: Any] {
        let user: [String: Any] = [
            "id":            canvasUser.id,
            "name":          canvasUser.name,
            "primary_email": canvasUser.loginID,
            "short_name":    canvasUser.shortName,
            "avatar_url":    canvasUser.avatarURL
        ]

        let baseURL = "https://\(canvasUser.domain)/"
        let authToken = canvasUser.token
        let loginInfo: [String: Any] = [
            "authToken": authToken,
            "baseURL": baseURL,
            "user": user
        ]

        return loginInfo
    }
}

class TeacherTest: XCTestCase {

    override func setUp() {
        super.setUp()
        BuddyBuildSDK.startUITests()
        CanvasKeymaster.the().resetKeymasterForTesting()
        NativeLoginManager.shared().injectLoginInformation(nil)
        GREYTestHelper.enableFastAnimation()
        loginPage.assertPageObjects()
    }

    override func tearDown() {
        BuddyBuildSDK.stopUITests()
        HelmManager.shared.cleanup { _ in }
        super.tearDown()
    }

    // logIn(self)
    func logIn2(_ user: Soseedy_CanvasUser) {
        let loginInfo = TeacherTestUtils.getUserLoginInfo2(user)
        NativeLoginManager.shared().injectLoginInformation(loginInfo)
        coursesListPage.assertPageObjects()
    }

    func deep(link: String) {
        guard let url = URL(string: link) else {
            XCTFail("Expected a URL, got: \(link)")
            return
        }
        RCTLinkingManager.application(.shared, open: url)
    }
}
