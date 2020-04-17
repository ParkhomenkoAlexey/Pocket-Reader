//
//  UserSettings.swift
//  Pocket Reader
//
//  Created by Алексей Пархоменко on 17.04.2020.
//  Copyright © 2020 Алексей Пархоменко. All rights reserved.
//

import UIKit

final class UserSettings {
    
    private enum SettingKey: String {
        case userBooks
    }
    
    static var userBooks: [BookItem] {
        get {
            guard let savedBooks = UserDefaults.standard.object(forKey: SettingKey.userBooks.rawValue) as? Data, let decodedBooks = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedBooks) as? [BookItem] else { return [] }
            return decodedBooks
        }
        set {
            let defaults = UserDefaults.standard
            let key = SettingKey.userBooks.rawValue

            if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: newValue, requiringSecureCoding: false) {
                print("value: \(newValue) was added to key \(key)")
                defaults.set(savedData, forKey: key)
            }
        }
    }
}
