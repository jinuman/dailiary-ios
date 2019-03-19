//
//  Environment.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 12. 27..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import Foundation

typealias JournalFactory = (String) -> JournalType

class Environment {
    let journalRepository: JournalRepository
    let journalFactory: JournalFactory
    var settings: Settings
    let now: () -> Date
    
    init(journalRepository: JournalRepository = InMemoryJournalRepository(),
         journalFactory: @escaping JournalFactory = { Journal(text: $0) },
         settings: Settings = InMemorySettings(),
         now: @escaping () -> Date = Date.init) {
        
        self.journalRepository = journalRepository
        self.journalFactory = journalFactory
        self.settings = settings
        self.now = now
    }
}
