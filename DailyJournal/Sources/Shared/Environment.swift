//
//  Environment.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 12. 27..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import Foundation

typealias EntryFactory = (String) -> EntryType

class Environment {
    let entryRepository: EntryRepository
    let entryFactory: EntryFactory
    var settings: Settings
    let now: () -> Date
    
    init(entryRepository: EntryRepository = InMemoryEntryRepository(),
         entryFactory: @escaping EntryFactory = { Entry(text: $0) },
         settings: Settings = InMemorySettings(),
         now: @escaping () -> Date = Date.init) {
        self.entryRepository = entryRepository
        self.entryFactory = entryFactory
        self.settings = settings
        self.now = now
    }
}
