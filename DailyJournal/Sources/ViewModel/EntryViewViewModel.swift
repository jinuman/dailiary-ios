//
//  EntryViewViewModel.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 12. 29..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit

protocol EntryViewViewModelDelegate: class {
    func didAddEntry(_ entry: Entry)
    func didRemoveEntry(_ entry: Entry)
}

class EntryViewViewModel {
    let environment: Environment
    private var entry: Entry?
    
    weak var delegate: EntryViewViewModelDelegate?
    
    private var repo: EntryRepository {
        return environment.entryRepository
    }
    
    init(environment: Environment, entry: Entry? = nil) {
        self.environment = environment
        self.entry = entry
    }
    
    var hasEntry: Bool {
        return entry != nil
    }
    
    var textViewText: String? {
        return entry?.text
    }
    
    var entryTitle: String {
        let date: Date = entry?.createdAt ?? environment.now()
        return DateFormatter.entryDateFormatter.string(from: date)
    }
    
    private(set) var isEditing: Bool = false
    
    var textViewEditable: Bool {
        return isEditing
    }
    
    var buttonImage: UIImage {
        return isEditing ? #imageLiteral(resourceName: "baseline_save_white_24pt") : #imageLiteral(resourceName: "baseline_edit_white_24pt")
    }
    
    func startEditing() {
        isEditing = true
    }
    
    func completeEditing(with text: String) {
        isEditing = false
        
        if let editingEntry = entry {
            editingEntry.text = text
            repo.update(editingEntry)
        } else {
            let newEntry = Entry(text: text)
            repo.add(newEntry)
            delegate?.didAddEntry(newEntry)
        }
    }
    
    var removeButtonEnabled: Bool {
        return hasEntry
    }
    
    func removeEntry() -> Entry? {
        guard let entryToRemove = entry else { return nil }
        repo.remove(entryToRemove)
        entry = nil
        delegate?.didRemoveEntry(entryToRemove)
        return entryToRemove
    }
}
