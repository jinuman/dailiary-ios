//
//  EntryViewController.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 12. 19..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController {
    
    @IBOutlet weak var saveEditButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    
    let repo = InMemoryEntryRepository.shared
    var editingEntry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date: Date = editingEntry?.createdAt ?? Date()
        title = DateFormatter.entryDateFormatter.string(from: date)
        
        textView.font = UIFont.systemFont(ofSize: 20)
        textView.text = editingEntry?.text
        
        let nc = NotificationCenter.default
        nc.addObserver(self,
                       selector: #selector(handleKeyboardAppearance(_:)),
                       name: UIResponder.keyboardWillShowNotification,
                       object: nil)
        nc.addObserver(self,
                       selector: #selector(handleKeyboardAppearance(_:)),
                       name: UIResponder.keyboardWillHideNotification,
                       object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateSubviews(isEditing: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    @objc func handleKeyboardAppearance(_ note: Notification) {
        guard
            let userInfo = note.userInfo,
            let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as?
                NSValue),
            let duration = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as?
                TimeInterval),
            let curve = (userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as?
                UInt)
            else { return }
        
        let isKeyboardWillShow: Bool = note.name ==
            UIResponder.keyboardWillShowNotification
        let keyboardHeight = isKeyboardWillShow ? keyboardFrame.cgRectValue.height : 0
        let animationOption = UIView.AnimationOptions.init(rawValue: curve)
        
        UIView.animate(
            withDuration:  duration,
            delay: 0.0,
            options: animationOption,
            animations: {
                self.textViewBottomConstraint.constant = -keyboardHeight
                self.view.layoutIfNeeded()
            },
            completion: nil)
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
        saveEditButton.image = isEditing ? #imageLiteral(resourceName: "baseline_save_white_24pt") : #imageLiteral(resourceName: "baseline_edit_white_24pt")
        saveEditButton.target = self
        saveEditButton.action = isEditing ? #selector(saveEntry(_:)) : #selector(editEntry(_:))
        textView.isEditable = isEditing
        _ = isEditing ? textView.becomeFirstResponder() : textView.resignFirstResponder()
    }
}
