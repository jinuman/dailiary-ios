//
//  Entry.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 12. 19..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import Foundation

protocol EntryType: class {
    var id: UUID { get }
    var createdAt: Date { get }
    var text: String { get set }
}

class Entry: EntryType {
    let id: UUID
    let createdAt: Date
    var text: String
    
    init(id: UUID = UUID(), createdAt: Date = Date(), text: String) {
        self.id = id
        self.createdAt = createdAt
        self.text = text
    }
}
