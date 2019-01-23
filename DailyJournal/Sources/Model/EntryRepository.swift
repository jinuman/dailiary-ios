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
    
    func add(_ entry: EntryType)
    func update(_ entry: EntryType)
    func remove(_ entry: EntryType)
    func entry(with id: UUID) -> EntryType?
    func recentEntries(max: Int) -> [EntryType]
}

class InMemoryEntryRepository: EntryRepository {
    private var entries: [UUID: EntryType]
    
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
    
    func add(_ entry: EntryType) {
        entries[entry.id] = entry
    }
    
    func update(_ entry: EntryType) {
        entries[entry.id] = entry
    }
    
    func remove(_ entry: EntryType) {
        entries[entry.id] = nil
    }
    
    func entry(with id: UUID) -> EntryType? {
        return entries[id]
    }
    
    func recentEntries(max: Int) -> [EntryType] {
        guard max >= 0 else { return [] }
        
        let result = entries
            .values
            .sorted { $0.createdAt > $1.createdAt  }
            .prefix(max)
        
        return Array(result)
    }
}

extension EntryRepository {
    var allEntries: [EntryType] {
        return recentEntries(max: numberOfEntries)
    }
    var uniqueDates: [Date] {
        return allEntries
            .compactMap { $0.createdAt.hmsRemoved }
            .unique()
    }
}
