//
//  JournalRepository.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 12. 19..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import Foundation

protocol JournalRepository {
    var numberOfJournals: Int { get }
    
    func add(_ journal: JournalType)
    func update(_ journal: JournalType, text: String)
    func remove(_ journal: JournalType)
    func journal(with id: UUID) -> JournalType?
    func journal(has string: String) -> [JournalType]
    func recentJournals(max: Int) -> [JournalType]
}

class InMemoryJournalRepository: JournalRepository {
    private var journals: [UUID: JournalType]
    
    init(journals: [Journal] = []) {
        var result: [UUID: Journal] = [:]
        
        journals.forEach { journal in
            result[journal.id] = journal
        }
        self.journals = result
    }
    
    static var shared: InMemoryJournalRepository = {
        let repository = InMemoryJournalRepository()
        return repository
    }()
    
    var numberOfJournals: Int {
        return journals.count
    }
    
    func add(_ journal: JournalType) {
        journals[journal.id] = journal
    }
    
    func update(_ journal: JournalType, text: String) {
        guard let journal = journal as? Journal else { fatalError() }
        journal.text = text
    }
    
    func remove(_ journal: JournalType) {
        journals[journal.id] = nil
    }
    
    func journal(with id: UUID) -> JournalType? {
        return journals[id]
    }
    
    func journal(has string: String) -> [JournalType] {
        let result = journals.values
            .filter { $0.text.contains(string) }
            .sorted { $0.createdAt > $1.createdAt }
        
        return Array(result)
    }

    
    func recentJournals(max: Int) -> [JournalType] {
        guard max >= 0 else { return [] }
        
        let result = journals.values
            .sorted { $0.createdAt > $1.createdAt  }
            .prefix(max)
        
        return Array(result)
    }
}

extension JournalRepository {
    var allJournals: [JournalType] {
        return recentJournals(max: numberOfJournals)
    }
    var uniqueDates: [Date] {
        return allJournals
            .compactMap { $0.createdAt.hmsRemoved }
            .unique()
    }
}
