//
//  TimelineViewViewModel.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 12. 28..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import Foundation

class TimelineViewViewModel {
    
    let environment: Environment
    var dates = [Date]()
    
    var repo: EntryRepository {
        return environment.entryRepository
    }
    private var entries: [Entry] {
        return repo.recentEntries(max: repo.numberOfEntries)
    }
    
    init(environment: Environment) {
        self.environment = environment
        self.dates = repo.uniqueDates
    }
    
    private func entries(for date: Date) -> [Entry] {
        return entries.filter {
            $0.createdAt.hmsRemoved == date
        }
    }
    
    func entry(for indexPath: IndexPath) -> Entry {
        let date = dates[indexPath.section]
        let entriesOfDate = entries(for: date)
        let entry = entriesOfDate[indexPath.row]
        return entry
    }
    
    func removeEntry(at indexPath: IndexPath) {
        let date = dates[indexPath.section]
        let entries = self.entries(for: date)
        let entryToRemove = entries[indexPath.row]
        environment.entryRepository.remove(entryToRemove)
        
        if entries.count == 1 {
            self.dates = self.dates.filter {
                $0 != date
            }
        }
    }
}

extension TimelineViewViewModel {
    var numberOfDates: Int {
        return dates.count
    }
    
    func headerTitle(of section: Int) -> String {
        let date = dates[section]
        return DateFormatter.entryDateFormatter.string(from: date)
    }
    
    func numberOfRows(in section: Int) -> Int {
        let date = dates[section]
        return entries(for: date).count
    }
}
