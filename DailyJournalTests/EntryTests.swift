//
//  DailyJournalTests.swift
//  DailyJournalTests
//
//  Created by Jinwoo Kim on 2018. 11. 9..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import XCTest
@testable import DailyJournal

class EntryTests: XCTestCase {

    func testEditEntryText() {
        // Setup
        let entry = Entry(text: "hello")
        
        // Run
        entry.text = "first journal"
        
        // Verify
        XCTAssertEqual(entry.text, "first journal")
    }
    
    func testEntryEqual() {
        // Setup
        let tempId: UUID = UUID()
        let tempDate: Date = Date()
        let entry = Entry(id: tempId, createdAt: tempDate, text: "1")
        let entry2 = Entry(id: tempId, createdAt: tempDate, text: "1")
        
        // Verify
        XCTAssertEqual(entry, entry2)
    }
    
    func testGetEntryById() {
        // Setup
        let id: UUID = UUID()
        let someEntry = Entry(id: id, createdAt: Date(), text: "1")
        let journal = InMemoryEntryRepository(entriesArray: [someEntry])
        
        // Run
        let entryById = journal.entry(with: id)
        
        // Verify
        XCTAssertEqual(entryById, .some(someEntry))
        XCTAssertTrue(entryById?.isIdentical(to: someEntry) == true)
    }

}


