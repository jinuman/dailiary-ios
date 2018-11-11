//
//  Entry.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 11. 11..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import Foundation

class Entry {
    let id: UUID
    let createdAt: Date
    var text: String
    
    init(id: UUID = UUID(), createdAt: Date = Date(), text: String) {
        self.id = id
        self.createdAt = createdAt
        self.text = text
    }
}

extension Entry: Equatable {
    static func ==(lhs: Entry, rhs: Entry) -> Bool {
        return lhs.id == rhs.id
            && lhs.createdAt == rhs.createdAt
            && lhs.text == rhs.text
    }
}

extension Entry: Identifiable { }
