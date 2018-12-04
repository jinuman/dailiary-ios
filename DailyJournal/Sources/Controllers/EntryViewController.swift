//
//  EntryViewController.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 11. 17..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit
import SnapKit

extension DateFormatter {
    static var entryDateFormatter: DateFormatter = { () -> DateFormatter in
        let df = DateFormatter()
        df.dateFormat = "yyyy. MM. dd. EEE"
        return df
    }()
}

let tmpTxt = """
There are five people in my family and I’m the second youngest.
I’m living in Bundang with my father and mother at the moment.
My older sister is living in Incheon since she had married.
My mother is doctor, as well as my father.
And I'm seeking for a job at the moment.
From now on, I'll tell you about my hobbies
Normally in my time, I’m doing iOS programming as a hobby.
And I like to ride bicycle and play guitar.
Most of my time I'm alone.
But I’m not lonely because I’m busy developing iOS App for my own.
I want to get a job as an iOS developer as soon as possible.
"""

extension UIColor {
    static let mint = UIColor(red: 150/255, green: 203/255, blue: 171/255, alpha: 1)
}

class EntryViewController: UIViewController {

    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        return button
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.text = tmpTxt
        textView.font = UIFont.systemFont(ofSize: 40)
        return textView
    }()
    
    
    
    var textViewBottomConstraint: Constraint!
    
    let repo: EntryRepository = InMemoryEntryRepository()
    private var editingEntry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        setupLayout()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(handleKeyboardAppearance),
                                       name: UIResponder.keyboardWillShowNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(handleKeyboardAppearance),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateSubviews(for: true)
    }
    
    @objc func handleKeyboardAppearance(_ note: Notification) {
        guard
            let userInfo = note.userInfo,
            let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
            let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? TimeInterval,
            let curve = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt
            else { return }
        
        let isKeyboardWillShow: Bool = note.name == UIResponder.keyboardWillShowNotification
        let keyboardHeight = isKeyboardWillShow ? keyboardFrame.cgRectValue.height : 0
        let animationOption = UIView.AnimationOptions.init(rawValue: curve)
        
        UIView.animate(withDuration: duration, delay: 0.0, options: animationOption, animations: {
            self.textViewBottomConstraint.update(offset: -keyboardHeight)
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
  
    
    private func addSubviews() {
        view.addSubview(textView)
    }
    
    private func setupLayout() {
        textView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.bottom.equalToSuperview()
            textViewBottomConstraint = $0.bottom.equalToSuperview().constraint
        }
    }
    
    @objc func saveEntry(_ sender: Any) {
        if let editing = editingEntry {
            editing.text = textView.text
            repo.update(editing)
        } else {
            let newEntry: Entry = Entry(text: textView.text)
            repo.add(newEntry)
            editingEntry = newEntry
        }
        updateSubviews(for: false)
        textView.resignFirstResponder()
    }
    
    @objc func editEntry(_ sender: Any) {
        updateSubviews(for: true)
        textView.becomeFirstResponder()
    }
    
    fileprivate func updateSubviews(for isEditing: Bool) {
        if isEditing {
            textView.isEditable = true
            
            button.setImage(#imageLiteral(resourceName: "baseline_save_white_36pt"), for: .normal)
            button.removeTarget(self, action: nil, for: .touchUpInside)
            button.addTarget(self,
                             action: #selector(saveEntry(_:)),
                             for: UIControl.Event.touchUpInside)
        } else {
            textView.isEditable = false
            
            button.setImage(#imageLiteral(resourceName: "baseline_edit_white_36pt"), for: .normal)
            button.removeTarget(self, action: nil, for: .touchUpInside)
            button.addTarget(self,
                             action: #selector(editEntry(_:)),
                             for: UIControl.Event.touchUpInside)
        }
    }
    
}
