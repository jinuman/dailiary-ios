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
    var numberOfEntries: Int { return 0 }
    
    func add(_ entry: EntryType) {
        
    }
    
    func update(_ entry: EntryType) {
        
    }
    
    func remove(_ entry: EntryType) {
        
    }
    
    func entry(with id: UUID) -> EntryType? {
        return nil
    }
    
    func recentEntries(max: Int) -> [EntryType] {
        return []
    }
    
    let realm: Realm
    
    init(realm: Realm) {
        self.realm = realm
    }
}
