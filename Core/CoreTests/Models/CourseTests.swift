//
// This file is part of Canvas.
// Copyright (C) 2018-present  Instructure, Inc.
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

import Foundation
import XCTest
@testable import Core

class CourseTests: CoreTestCase {
    func testColor() {
        let a = Course.make()
        ContextColor.make()

        XCTAssertEqual(a.color, UIColor.red)
    }

    func testDefaultView() {
        let expected = CourseDefaultView.assignments
        let a = Course.make()
        a.defaultView = expected

        XCTAssertEqual(a.defaultView, expected)
    }

    func testEnrollmentRelationship() {
        let a = Course.make()
        let enrollment = Enrollment.make(course: a)
        a.enrollments = [enrollment]

        let pred = NSPredicate(format: "%K == %@", #keyPath(Course.id), a.id)
        let list: [Course] = databaseClient.fetch(pred, sortDescriptors: nil)
        let result = list.first
        let resultEnrollment = result?.enrollments?.first

        XCTAssertNotNil(result)
        XCTAssertNotNil(result?.enrollments)
        XCTAssertNotNil(resultEnrollment)
        XCTAssertEqual(resultEnrollment?.canvasContextID, "course_1")
    }

    func testWidgetDisplayGradeNoEnrollments() {
        let c = Course.make(from: .make(enrollments: nil))
        XCTAssertEqual(c.displayGrade, "")
    }

    func testWidgetDisplayGradeNoStudentEnrollments() {
        let c = Course.make(from: .make(enrollments: [.make(type: "TeacherEnrollment")]))
        XCTAssertEqual(c.displayGrade, "")
    }

    func testWidgetDisplayGradeScore() {
        let c = Course.make(from: .make(enrollments: [.make(computed_current_score: 40.05)]))
        XCTAssertEqual(c.displayGrade, "40.05%")
    }

    func testWidgetDisplayGradeScoreAndGrade() {
        let c = Course.make(from: .make(enrollments: [ .make(
            computed_current_score: 40.05,
            computed_current_grade: "F-"
        ), ]))
        XCTAssertEqual(c.displayGrade, "40.05% - F-")
    }

    func testWidgetDisplayGradeNoScoreWithGrade() {
        let c = Course.make(from: .make(enrollments: [ .make(
            computed_current_score: nil,
            computed_current_grade: "B+"
        ), ]))
        XCTAssertEqual(c.displayGrade, "B+")
    }

    func testWidgetDisplayGradeNoScoreNoGrade() {
        let c = Course.make(from: .make(enrollments: [ .make(
            computed_current_score: nil,
            computed_current_grade: nil
        ), ]))
        XCTAssertEqual(c.displayGrade, "N/A")
    }

    func testWidgetDisplayGradeInCurrentMGP() {
        let c = Course.make(from: .make(enrollments: [ .make(
            multiple_grading_periods_enabled: true,
            current_grading_period_id: "1",
            current_period_computed_current_score: 90,
            current_period_computed_current_grade: "A-"
        ), ]))
        XCTAssertEqual(c.displayGrade, "90% - A-")
    }

    func testWidgetDisplayGradeNotInCurrentMGPWithTotals() {
        let c = Course.make(from: .make(enrollments: [ .make(
            computed_final_score: 85,
            computed_final_grade: "B",
            multiple_grading_periods_enabled: true,
            totals_for_all_grading_periods_option: true,
            current_grading_period_id: nil
        ), ]))
        XCTAssertEqual(c.displayGrade, "85% - B")
    }

    func testWidgetDisplayGradeNotInCurrentMGPWithoutTotals() {
        let c = Course.make(from: .make(enrollments: [ .make(
            multiple_grading_periods_enabled: true,
            totals_for_all_grading_periods_option: false,
            current_grading_period_id: nil
        ), ]))
        XCTAssertEqual(c.displayGrade, "N/A")
    }

    func testShowColorOverlay() {
        let c = Course.make(from: .make(image_download_url: nil))
        XCTAssertTrue(c.showColorOverlay(hideOverlaySetting: false))

        c.imageDownloadURL = URL(string: "https://google.com")!
        XCTAssertFalse(c.showColorOverlay(hideOverlaySetting: true))
        XCTAssertTrue(c.showColorOverlay(hideOverlaySetting: false))
    }

    func testHasStudentEnrollment() {
        XCTAssertFalse(Course.make(from: .make(enrollments: [])).hasStudentEnrollment)
        XCTAssertFalse(Course.make(from: .make(enrollments: [.make(type: "TeacherEnrollment")])).hasStudentEnrollment)
        XCTAssertTrue(Course.make(from: .make(enrollments: [.make(type: "StudentEnrollment")])).hasStudentEnrollment)
        XCTAssertTrue(Course.make(from: .make(enrollments: [.make(type: "StudentEnrollment"), .make(type: "TeacherEnrollment")])).hasStudentEnrollment)
    }
}
