//
//  UserDefaultsMock.swift
//  DailiaryTests
//
//  Created by Jinwoo Kim on 2021/03/18.
//

import Foundation

final class UserDefaultsMock: UserDefaults {
    override init?(suiteName: String?) {
        super.init(suiteName: "__test")
    }
    
    deinit {
        for key in self.dictionaryRepresentation().keys {
            self.removeObject(forKey: key)
        }
    }
}
