//
//  RealmEntry.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 23/01/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import Foundation
import RealmSwift

class RealmEntry: Object, EntryType {
    var id: UUID {
        guard let uuid = UUID(uuidString: uuidString) else { fatalError() }
        return uuid
    }
    
    @objc dynamic var uuidString: String = ""
    @objc dynamic var createdAt: Date = Date()
    @objc dynamic var text: String = ""
    
    override static func primaryKey() -> String? {
        return "uuidString"
    }
    
}

extension RealmEntry {
    static func entry(with text: String) -> RealmEntry{
        let entry = RealmEntry()
        entry.uuidString = UUID().uuidString
        entry.createdAt = Date()
        entry.text = text
        return entry
    }
}
