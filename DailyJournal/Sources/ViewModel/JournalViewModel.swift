//
//  JournalViewModel.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 12. 29..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit

class JournalViewModel {
    let environment: Environment
    private var journal: JournalType?
    
    weak var delegate: TimelineTableViewModelDelegate?
    
    private var repo: JournalRepository {
        return environment.journalRepository
    }
    
    init(environment: Environment, journal: JournalType? = nil) {
        self.environment = environment
        self.journal = journal
    }
    
    var hasJournal: Bool {
        return journal != nil
    }
    
    var textViewText: String? {
        return journal?.text
    }
    
    var textViewFont: UIFont {
        return UIFont.systemFont(ofSize: environment.settings.fontSizeOption.rawValue)
    }
    
    var journalTitle: String {
        let date: Date = journal?.createdAt ?? environment.now()
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
        
        if let editingJournal = journal {
            repo.update(editingJournal, text: text)
        } else {
            let newJournal = environment.journalFactory(text)
            repo.add(newJournal)
            self.journal = newJournal
            delegate?.didAddJournal(newJournal)
        }
    }
    
    var removeButtonEnabled: Bool {
        return hasJournal
    }
    
    func removeJournal() -> JournalType? {
        guard let journalToRemove = journal else { return nil }
        repo.remove(journalToRemove)
        journal = nil
        delegate?.didRemoveJournal(journalToRemove)
        return journalToRemove
    }
}
