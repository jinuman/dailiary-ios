//
//  Environment.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 12. 27..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import Foundation

class Environment {
    let entryRepository: EntryRepository
    let settings: Settings
    let now: () -> Date
    
    init(entryRepository: EntryRepository = InMemoryEntryRepository(),
         settings: Settings = InMemorySettings(),
         now: @escaping () -> Date = Date.init) {
        self.entryRepository = entryRepository
        self.settings = settings
        self.now = now
    }
}
