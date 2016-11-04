
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
    
    

import ReactiveCocoa
import TooLegit
import CoreData
import SoPersistent

extension Grade {
    static func coursePredicate(courseID: String) -> NSPredicate {
        return NSPredicate(format: "%K == %@", "course.id", courseID)
    }

    static func gradingPeriodPredicate(gradingPeriodID: String?) -> NSPredicate {
        guard let gradingPeriodID = gradingPeriodID else {
            return NSPredicate(format: "%K == nil", "gradingPeriodID")
        }
        return NSPredicate(format: "%K == %@", "gradingPeriodID", gradingPeriodID)
    }

    static func predicate(courseID: String, gradingPeriodID: String?) -> NSPredicate {
        let gradingPeriod = Grade.gradingPeriodPredicate(gradingPeriodID)
        let course = Grade.coursePredicate(courseID)
        return NSCompoundPredicate(andPredicateWithSubpredicates: [gradingPeriod, course])
    }

    public static func collectionByCourseID(session: Session, courseID: String) throws -> FetchedCollection<Grade> {
        let context = try session.enrollmentManagedObjectContext()
        let frc = fetchedResults(coursePredicate(courseID), sortDescriptors: [], sectionNameKeypath: nil, inContext: context)
        return try FetchedCollection(frc: frc)
    }

    public static func refreshSignalProducer(session: Session, courseID: String, gradingPeriodID: String?) throws -> SignalProducer<[Grade], NSError> {
        let context = try session.enrollmentManagedObjectContext()
        let remote = try Grade.getGrades(session, courseID: courseID, gradingPeriodID: gradingPeriodID)
        let local = predicate(courseID, gradingPeriodID: gradingPeriodID)
        return Grade.syncSignalProducer(local, inContext: context, fetchRemote: remote)
    }
}
