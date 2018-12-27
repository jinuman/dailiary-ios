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
    
    var environment: Environment!
    var repo: EntryRepository {
        return environment.entryRepository
    }
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
                       selector: #selector(handleKeyboardAppear(_:)),
                       name: UIResponder.keyboardWillShowNotification,
                       object: nil)
        nc.addObserver(self,
                       selector: #selector(handleKeyboardAppear(_:)),
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
    
    @objc func handleKeyboardAppear(_ note: Notification) {
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
        let alertController = UIAlertController(
            title: "저장할까요?",
            message: nil,
            preferredStyle: .alert
        )
        
        let saveAction: UIAlertAction = UIAlertAction(title: "저장", style: .default) { [weak self] (_) in
            if let editing = self?.editingEntry {
                editing.text = self?.textView.text ?? ""
                self?.repo.update(editing)
            } else {
                let entry: Entry = Entry(text: self?.textView.text ?? "")
                self?.repo.add(entry)
                self?.editingEntry = entry
            }
            self?.updateSubviews(isEditing: false)
        }
        let cancelAction: UIAlertAction = UIAlertAction(
            title: "취소",
            style: .cancel,
            handler: nil
        )
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func editEntry(_ sender: UIBarButtonItem) {
        updateSubviews(isEditing: true)
    }
    
    @IBAction func removeEntry(_ sender: Any) {
        guard let entryToRemove = editingEntry else { return }
        
        let alertController = UIAlertController(
            title: "현재 일기를 삭제할까요?",
            message: "이 동작은 되돌릴 수 없습니다",
            preferredStyle: .actionSheet
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
