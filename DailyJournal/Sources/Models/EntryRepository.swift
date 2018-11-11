//
//  EntryRepository.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 11. 11..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import Foundation

protocol EntryRepository {
    var entryCount: Int { get }
    
    func add(_ entry: Entry)
    func update(_ entry: Entry)
    func remove(_ entry: Entry)
    func entry(with id: UUID) -> Entry?
    func recentEntries(max: Int) -> [Entry]
}

class InMemoryEntryRepository: EntryRepository {
    private var entries: [UUID : Entry]
    
    init(entriesArray: [Entry] = []) {
        var tempDic: [UUID : Entry] = [ : ]
        entriesArray.forEach { entry in
            tempDic[entry.id] = entry
        }
        self.entries = tempDic
    }
    
    var entryCount: Int {
        return entries.count
    }
    
    func add(_ entry: Entry) {
        entries[entry.id] = entry
    }
    
    func update(_ entry: Entry) {
        entries[entry.id] = entry
    }
    
    func remove(_ entry: Entry) {
        entries[entry.id] = nil
    }
    
    func entry(with id: UUID) -> Entry? {
        return entries[id]
    }
    
    func recentEntries(max: Int) -> [Entry] {
        guard max >= 0 else { return [] }
        
        let result = entries
            .values
            .sorted { $0.createdAt > $1.createdAt  }
            .prefix(max)
        
        return Array(result)
    }
}
