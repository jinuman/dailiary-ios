//
//  RealmEntryRepository.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 23/01/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import Foundation
import RealmSwift

class RealmEntryRepository: EntryRepository {
    private let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
    
    func add(_ entry: EntryType) {
        guard let realmEntry = entry as? RealmEntry else { fatalError() }
        do {
            try realm.write {
                realm.add(realmEntry)
            }
        } catch {
            print(error)
        }
    }
    
    func update(_ entry: EntryType, text: String) {
        guard let realmEntry = entry as? RealmEntry else { fatalError() }
        do {
            try realm.write {
                realmEntry.text = text
                realm.add(realmEntry, update: true)
            }
        } catch {
            print(error)
        }
    }
    
    func remove(_ entry: EntryType) {
        guard let realmEntry = entry as? RealmEntry else { fatalError() }
        do {
            try realm.write {
                realm.delete(realmEntry)
            }
        } catch {
            print(error)
        }
    }
    
    var numberOfEntries: Int {
        return realm.objects(RealmEntry.self).count
    }
    
    func entry(with id: UUID) -> EntryType? {
        return realm.objects(RealmEntry.self)
            .filter("uuidString == '\(id.uuidString)'")
            .first
    }
    
    func entries(has string: String) -> [EntryType] {
        let result = realm.objects(RealmEntry.self)
            .filter("text CONTAINS[c] '\(string)'")
            .sorted(byKeyPath: "createdAt", ascending: false)
        
        return Array(result)
    }
    
    func recentEntries(max: Int) -> [EntryType] {
        let results = realm.objects(RealmEntry.self)
            .sorted(byKeyPath: "createdAt", ascending: false)
            .prefix(max)
        
        return Array(results)
    }
    
    
}
