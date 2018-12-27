//
//  EntryRepository.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 12. 19..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import Foundation

protocol EntryRepository {
    var numberOfEntries: Int { get }
    
    func add(_ entry: Entry)
    func update(_ entry: Entry)
    func remove(_ entry: Entry)
    func entry(with id: UUID) -> Entry?
    func recentEntries(max: Int) -> [Entry]
}

class InMemoryEntryRepository: EntryRepository {
    private var entries: [UUID: Entry]
    
    init(entries: [Entry] = []) {
        var result: [UUID: Entry] = [:]
        
        entries.forEach { entry in
            result[entry.id] = entry
        }
        self.entries = result
    }
    
    static var shared: InMemoryEntryRepository = {
        let repository = InMemoryEntryRepository()
        return repository
    }()
    
    var numberOfEntries: Int {
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

extension EntryRepository {
    var allEntries: [Entry] {
        return recentEntries(max: numberOfEntries)
    }
    var uniqueDates: [Date] {
        return allEntries.compactMap {
            $0.createdAt.hmsRemoved
        }.unique()
    }
}
