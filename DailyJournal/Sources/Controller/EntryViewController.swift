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
    @IBOutlet weak var removeButton: UIBarButtonItem!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textViewBottomConstraint: NSLayoutConstraint!
    var viewModel: EntryViewViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.entryTitle
        
        textView.text = viewModel.textViewText
        textView.font = viewModel.textViewFont
        
        if viewModel.hasEntry == false {
            viewModel.startEditing()
        }
        updateSubviews()
        
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if viewModel.isEditing {
            textView.becomeFirstResponder()
        }
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
            self?.viewModel.completeEditing(with: self?.textView.text ?? "")
            self?.updateSubviews()
            self?.textView.resignFirstResponder()
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
        viewModel.startEditing()
        updateSubviews()
        textView.becomeFirstResponder()
    }
    
    @IBAction func removeEntry(_ sender: Any) {
        guard viewModel.hasEntry else { return }
        
        let alertController = UIAlertController(
            title: "현재 일기를 삭제할까요?",
            message: "이 동작은 되돌릴 수 없습니다",
            preferredStyle: .actionSheet
        )
        
        let removeAction: UIAlertAction = UIAlertAction(title: "삭제", style: .destructive) { (_) in
            guard let _ = self.viewModel.removeEntry() else { return }
            self.navigationController?.popViewController(animated: true)
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
    
    fileprivate func updateSubviews() {
        saveEditButton.image = viewModel.buttonImage
        saveEditButton.target = self
        saveEditButton.action = viewModel.isEditing ? #selector(saveEntry(_:)) : #selector(editEntry(_:))
        removeButton.isEnabled = viewModel.removeButtonEnabled
        textView.isEditable = viewModel.textViewEditable
    }
}
