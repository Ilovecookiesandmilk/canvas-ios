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

public class ComposeMessageInteractorLive: ComposeMessageInteractor {
    // MARK: - Outputs
    public var state = CurrentValueSubject<StoreState, Never>(.loading)
    public var courses = CurrentValueSubject<[InboxCourse], Never>([])

    // MARK: - Private
    private var subscriptions = Set<AnyCancellable>()
    private let env: AppEnvironment
    private let courseListStore: Store<GetInboxCourseList>

    public init(env: AppEnvironment) {
        self.env = env
        self.courseListStore = env.subscribe(GetInboxCourseList())

        courseListStore
            .statePublisher
            .subscribe(state)
            .store(in: &subscriptions)

        courseListStore
            .allObjects
            .subscribe(courses)
            .store(in: &subscriptions)
        courseListStore.exhaust()
    }

    public func send() -> Future<Void, Never> {
        Future<Void, Never> { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                promise(.success(()))
            }
        }
    }
}
