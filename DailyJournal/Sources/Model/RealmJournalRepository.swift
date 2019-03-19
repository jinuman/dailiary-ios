//
//  RealmJournalRepository.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 23/01/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import Foundation
import RealmSwift

class RealmJournalRepository: JournalRepository {
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func add(_ journal: JournalType) {
        guard let realmJournal = journal as? RealmJournal else { fatalError() }
        do {
            try realm.write {
                realm.add(realmJournal)
            }
        } catch {
            print(error)
        }
    }
    
    func update(_ journal: JournalType, text: String) {
        guard let realmJournal = journal as? RealmJournal else { fatalError() }
        do {
            try realm.write {
                realmJournal.text = text
                realm.add(realmJournal, update: true)
            }
        } catch {
            print(error)
        }
    }
    
    func remove(_ journal: JournalType) {
        guard let realmJournal = journal as? RealmJournal else { fatalError() }
        do {
            try realm.write {
                realm.delete(realmJournal)
            }
        } catch {
            print(error)
        }
    }
    
    var numberOfJournals: Int {
        return realm.objects(RealmJournal.self).count
    }
    
    func journal(with id: UUID) -> JournalType? {
        return realm.objects(RealmJournal.self)
            .filter("uuidString == '\(id.uuidString)'")
            .first
    }
    
    func journal(has string: String) -> [JournalType] {
        let result = realm.objects(RealmJournal.self)
            .filter("text CONTAINS[c] '\(string)'")
            .sorted(byKeyPath: "createdAt", ascending: false)
        
        return Array(result)
    }
    
    func recentJournals(max: Int) -> [JournalType] {
        let results = realm.objects(RealmJournal.self)
            .sorted(byKeyPath: "createdAt", ascending: false)
            .prefix(max)
        
        return Array(results)
    }
    
    
}
