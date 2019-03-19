//
//  TimelineTableViewModel.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 12. 28..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit

class TimelineTableViewModel {
    
    let environment: Environment
    private var dates = [Date]()
    
    private var repo: JournalRepository {
        return environment.journalRepository
    }
    private var journals: [JournalType] {
        return repo.allJournals
    }
    
    private var filteredEntries: [JournalType] = []
    
    var searchText: String? {
        didSet {
            guard let text = searchText else {
                filteredEntries = []
                return
            }
            filteredEntries = environment.journalRepository.journal(has: text)
        }
    }
    
    var isSearching: Bool {
        return searchText?.isEmpty == false
    }
    
    init(environment: Environment) {
        self.environment = environment
        self.dates = repo.uniqueDates
    }
    
    private func entries(for date: Date) -> [JournalType] {
        return journals.filter {
            $0.createdAt.hmsRemoved == date
        }
    }
    
    private func journal(for indexPath: IndexPath) -> JournalType {
        guard isSearching == false else {
            return filteredEntries[indexPath.row]
        }
        
        let date = dates[indexPath.section]
        let journal = entries(for: date)[indexPath.row]
        return journal
    }
    
    func removeJournal(at indexPath: IndexPath) {
        let date = dates[indexPath.section]
        let entries = self.entries(for: date)
        let journalToRemove = entries[indexPath.row]
        repo.remove(journalToRemove)
        
        if entries.count == 1 {
            self.dates = self.dates.filter {
                $0 != date
            }
        }
    }
    
    var newJournalViewViewModel: JournalViewModel {
        let vm = JournalViewModel(environment: environment)
        vm.delegate = self
        return vm
    }
    
    func journalViewViewModel(for indexPath: IndexPath) -> JournalViewModel {
        let vm = JournalViewModel(environment: environment, journal: journal(for: indexPath))
        vm.delegate = self
        return vm
    }
    
    func timelineTableViewCellViewModel(for indexPath: IndexPath) -> TimelineTableCellViewModel {
        let journal = self.journal(for: indexPath)
        
        return TimelineTableCellViewModel(
            journalText: journal.text,
            journalTextFont: UIFont.systemFont(ofSize: environment.settings.fontSizeOption.rawValue),
            ampmText: DateFormatter.journalTimeFormatter.string(from: journal.createdAt),
            timeText: DateFormatter.ampmFormatter.string(from: journal.createdAt)
        )
    }
    
    lazy var settingsViewModel: SettingsViewModel =
        SettingsViewModel(environment: environment)
}

extension TimelineTableViewModel {
    var numberOfDates: Int {
        return isSearching ? 1 : dates.count
    }
    
    func headerTitle(of section: Int) -> String? {
        guard isSearching == false else { return nil }
        
        let date = dates[section]
        return DateFormatter.formatter(with: environment.settings.dateFormatOption.rawValue).string(from: date)
    }
    
    func numberOfRows(in section: Int) -> Int {
        guard isSearching == false else { return filteredEntries.count }
        
        let date = dates[section]
        return entries(for: date).count
    }
}

extension TimelineTableViewModel: JournalViewModelDelegate {
    func didAddJournal(_ journal: JournalType) {
        dates = repo.uniqueDates
    }
    
    func didRemoveJournal(_ journal: JournalType) {
        dates = repo.uniqueDates
    }
}
