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
    
    func testAddEntry() {
        // Setup
        let id: UUID = UUID()
        let someEntry = Entry(id: id, createdAt: Date(), text: "1")
        let journal = InMemoryEntryRepository()
        
        // Run
        journal.add(someEntry)
        
        // Verify
        XCTAssertEqual(journal.entry(with: id), .some(someEntry))
    }
    
    func testUpdateEntry() {
        // Setup
        let id: UUID = UUID()
        let someEntry = Entry(id: id, createdAt: Date(), text: "1")
        let journal = InMemoryEntryRepository(entriesArray: [someEntry])
        
        // Run
        someEntry.text = "일기 내용 수정"
        journal.update(someEntry)
        
        // Verify
        let entry = journal.entry(with: id)
        XCTAssertEqual(entry, .some(someEntry))
        XCTAssertTrue(entry?.isIdentical(to: someEntry) == true)
        XCTAssertEqual(entry?.text, .some("일기 내용 수정"))
    }
    
    func testRemoveEntry() {
        // Setup
        let id: UUID = UUID()
        let someEntry = Entry(id: id, createdAt: Date(), text: "1")
        let journal = InMemoryEntryRepository(entriesArray: [someEntry])
        
        // Run
        journal.remove(someEntry)
        
        // Verify
        let entry = journal.entry(with: id)
        XCTAssertEqual(entry, nil)
    }
    
    func test_최근_순으로_엔트리를_불러올_수_있다() {
        // Setup
        let dayBeforeYesterday = Entry(id: UUID(), createdAt: Date.distantPast, text: "그저께 일기")
        let yesterDay = Entry(id: UUID(), createdAt: Date(), text: "어제 일기")
        let today = Entry(id: UUID(), createdAt: Date.distantFuture, text: "오늘 일기")
        
        let journal = InMemoryEntryRepository(entriesArray: [dayBeforeYesterday, yesterDay, today])
        
        // Run
        let entries = journal.recentEntries(max: 3)
        
        // Verify
        XCTAssertEqual(entries.count, 3)
        XCTAssertEqual(entries, [today, yesterDay, dayBeforeYesterday])
    }
    
    func test_요청한_엔트리의_수만큼_최신_순으로_반환한다() {
        // Setup
        let dayBeforeYesterday = Entry(id: UUID(), createdAt: Date.distantPast, text: "그저께 일기")
        let yesterDay = Entry(id: UUID(), createdAt: Date(), text: "어제 일기")
        let today = Entry(id: UUID(), createdAt: Date.distantFuture, text: "오늘 일기")
        
        let journal = InMemoryEntryRepository(entriesArray: [dayBeforeYesterday, yesterDay, today])
        
        // Run
        let entries = journal.recentEntries(max: 1)
        
        // Verify
        XCTAssertEqual(entries.count, 1)
        XCTAssertEqual(entries, [today])
    }
    
    func test_존재하는_엔트리보다_많은_수를_요청하면_존재하는_엔트리만큼만_반환한다() {
        // Setup
        let dayBeforeYesterday = Entry(id: UUID(), createdAt: Date.distantPast, text: "그저께 일기")
        let yesterDay = Entry(id: UUID(), createdAt: Date(), text: "어제 일기")
        let today = Entry(id: UUID(), createdAt: Date.distantFuture, text: "오늘 일기")
        
        let journal = InMemoryEntryRepository(entriesArray: [dayBeforeYesterday, yesterDay, today])
        
        // Run
        let entries = journal.recentEntries(max: 10)
        
        // Verify
        XCTAssertEqual(entries.count, 3)
        XCTAssertEqual(entries, [today, yesterDay, dayBeforeYesterday])
    }

}


