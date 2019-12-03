//
//  UserDefaultsValue.swift
//  ToDoList
//
//  Created by Tharmika Thiyagarajah on 11/22/19.
//  Copyright © 2019 Axel Ancona Esselmann. All rights reserved.
//

import Foundation

@propertyWrapper
struct UserDefaultValue<Value: Codable> {
    
    let key: String
    let defaultValue: Value
    
    private let storage = UserDefaults.standard
    
    var wrappedValue: Value {
        get {
            let data = storage.data(forKey: key)
            let value = data.flatMap { try? JSONDecoder().decode(Value.self, from: $0) }
            return value ?? defaultValue
        }
        set {
            let data = try? JSONEncoder().encode(newValue)
            storage.set(data, forKey: key)
            storage.synchronize()
        }
    }
    
}
