//
//  EntryViewViewModel.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 12. 29..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit

protocol EntryViewViewModelDelegate: class {
    func didAddEntry(_ entry: EntryType)
    func didRemoveEntry(_ entry: EntryType)
}

class EntryViewViewModel {
    let environment: Environment
    private var entry: EntryType?
    
    weak var delegate: EntryViewViewModelDelegate?
    
    private var repo: EntryRepository {
        return environment.entryRepository
    }
    
    init(environment: Environment, entry: EntryType? = nil) {
        self.environment = environment
        self.entry = entry
    }
    
    var hasEntry: Bool {
        return entry != nil
    }
    
    var textViewText: String? {
        return entry?.text
    }
    
    var textViewFont: UIFont {
        return UIFont.systemFont(ofSize: environment.settings.fontSizeOption.rawValue)
    }
    
    var entryTitle: String {
        let date: Date = entry?.createdAt ?? environment.now()
        return DateFormatter.formatter(with: environment.settings.dateFormatOption.rawValue).string(from: date)
    }
    
    private(set) var isEditing: Bool = false
    
    var textViewEditable: Bool {
        return isEditing
    }
    
    var buttonImage: UIImage {
        return isEditing ? #imageLiteral(resourceName: "baseline_save_black_24pt") : #imageLiteral(resourceName: "baseline_edit_black_24pt")
    }
    
    func startEditing() {
        isEditing = true
    }
    
    func completeEditing(with text: String) {
        isEditing = false
        
        if let editingEntry = entry {
            repo.update(editingEntry, text: text)
        } else {
            let newEntry = environment.entryFactory(text)
            repo.add(newEntry)
            self.entry = newEntry
            delegate?.didAddEntry(newEntry)
        }
    }
    
    var removeButtonEnabled: Bool {
        return hasEntry
    }
    
    func removeEntry() -> EntryType? {
        guard let entryToRemove = entry else { return nil }
        repo.remove(entryToRemove)
        entry = nil
        delegate?.didRemoveEntry(entryToRemove)
        return entryToRemove
    }
}
