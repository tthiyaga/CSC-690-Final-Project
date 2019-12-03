//
//  UserData.swift
//  ToDoList
//
//  Created by Tharmika Thiyagarajah on 11/22/19.
//  Copyright © 2019 Axel Ancona Esselmann. All rights reserved.
//

import Combine
import SwiftUI

private let defaultTasks: [Task] = []

final class UserData: ObservableObject {
    let didChange = PassthroughSubject<UserData, Never>()
    private var value: UserDefaultValue<[Task]> = UserDefaultValue(key: "Tasks", defaultValue: defaultTasks)
    
    init() {
        tasks = value.wrappedValue
    }
    
    @Published
    var tasks: [Task] {
      didSet {
        value.wrappedValue = tasks
        didChange.send(self)
      }
    }
    
}
