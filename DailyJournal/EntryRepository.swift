//
//  EntryRepository.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 11. 11..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import Foundation

protocol EntryRepository {
    var numOfEntries: Int { get }
    
    func add(_ entry: Entry)
    func update(_ entry: Entry)
    func remove(_ entry: Entry)
    func entry(with id: UUID) -> Entry?
    func recentEntries(max: Int) -> [Entry]
}
