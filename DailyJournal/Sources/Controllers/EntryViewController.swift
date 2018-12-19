//
//  EntryViewController.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 12. 19..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit

protocol EntryViewControllerDelegate: class {
    func didRemoveEntry(_ entry: Entry)
}

class EntryViewController: UIViewController {
    
    @IBOutlet weak var saveEditButton: UIBarButtonItem!
    @IBOutlet weak var removeButton: UIBarButtonItem!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    
    let repo = InMemoryEntryRepository.shared
    var editingEntry: Entry?
    weak var delegate: EntryViewControllerDelegate?
    private var hasEntry: Bool {
        return editingEntry != nil
    }
    
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
    
    @IBAction func removeEntry(_ sender: Any) {
        guard let entryToRemove = editingEntry else { return }
        
        let alertController = UIAlertController(
            title: "현재 일기를 삭제할까요?",
            message: "이 동작은 되돌릴 수 없습니다",
            preferredStyle: .alert
        )
        
        let removeAction: UIAlertAction = UIAlertAction(title: "삭제", style: .destructive) { (_) in
                self.repo.remove(entryToRemove)
                self.editingEntry = nil
                self.delegate?.didRemoveEntry(entryToRemove)
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(
            title: "취소",
            style: .cancel,
            handler: nil
        )
        
        alertController.addAction(removeAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func updateSubviews(isEditing: Bool) {
        saveEditButton.image = isEditing ? #imageLiteral(resourceName: "baseline_save_white_24pt") : #imageLiteral(resourceName: "baseline_edit_white_24pt")
        saveEditButton.target = self
        saveEditButton.action = isEditing ? #selector(saveEntry(_:)) : #selector(editEntry(_:))
        removeButton.isEnabled = hasEntry
        textView.isEditable = isEditing
        _ = isEditing ? textView.becomeFirstResponder() : textView.resignFirstResponder()
    }
}
