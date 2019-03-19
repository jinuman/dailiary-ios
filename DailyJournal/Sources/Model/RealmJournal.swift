//
//  RealmJournal.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 23/01/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import Foundation
import RealmSwift

class RealmJournal: Object, JournalType {
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

extension RealmJournal {
    static func journal(with text: String) -> RealmJournal {
        let journal = RealmJournal()
        journal.uuidString = UUID().uuidString
        journal.createdAt = Date()
        journal.text = text
        return journal
    }
}
