//
//  EntryViewController.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 12. 19..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit

let longtxt = """
I want to get a job as an iOS developer as soon as possible.
I want to get a job as an iOS developer as soon as possible.
I want to get a job as an iOS developer as soon as possible.
I want to get a job as an iOS developer as soon as possible.
I want to get a job as an iOS developer as soon as possible.
I want to get a job as an iOS developer as soon as possible.
I want to get a job as an iOS developer as soon as possible.
I want to get a job as an iOS developer as soon as possible.
I want to get a job as an iOS developer as soon as possible.
I want to get a job as an iOS developer as soon as possible.
I want to get a job as an iOS developer as soon as possible.
"""

class EntryViewController: UIViewController {

    @IBOutlet weak var saveEditButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    
    let repo = InMemoryEntryRepository.shared
    private var editingEntry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = DateFormatter.entryDateFormatter.string(from: Date())
        textView.font = UIFont.systemFont(ofSize: 40)
        textView.text = longtxt
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateSubviews(isEditing: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func saveEntry(_ sender: UIBarButtonItem) {
        if let editing = editingEntry {
            editing.text = textView.text
            repo.update(editing)
        } else {
            let entry: Entry = Entry(text: textView.text)
            repo.add(entry)
            editingEntry = entry
        }
        updateSubviews(isEditing: false)
    }
    
    @objc func editEntry(_ sender: UIBarButtonItem) {
        updateSubviews(isEditing: true)
    }
    
    fileprivate func updateSubviews(isEditing: Bool) {
        if isEditing {
            textView.isEditable = true
            textView.becomeFirstResponder()
            
            saveEditButton.image = #imageLiteral(resourceName: "baseline_save_white_24pt")
            saveEditButton.target = self
            saveEditButton.action = #selector(saveEntry(_:))
        } else {
            textView.isEditable = false
            textView.resignFirstResponder()
            
            saveEditButton.image = #imageLiteral(resourceName: "baseline_edit_white_24pt")
            saveEditButton.target = self
            saveEditButton.action = #selector(editEntry(_:))
        }
    }
}
