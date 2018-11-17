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

class EntryViewController: UIViewController {
    let headerView: UIView = UIView()
    let textView: UITextView = UITextView()
    let dateLabel: UILabel = UILabel()
    let button: UIButton = UIButton()
    
    let repo: EntryRepository = InMemoryEntryRepository()
    private var editingEntry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        layout()
        
        headerView.backgroundColor = UIColor.init(red: 0.909, green: 0.510, blue: 0.488, alpha: 1.0)
        textView.text = tmpTxt
        textView.font = UIFont.systemFont(ofSize: 50)
        dateLabel.text = DateFormatter.entryDateFormatter.string(from: Date())
        dateLabel.textColor = UIColor.white
        button.tintColor = UIColor.white
        updateSubviews(for: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    
    private func addSubviews() {
        headerView.addSubview(dateLabel)
        headerView.addSubview(button)
        view.addSubview(headerView)
        view.addSubview(textView)
    }
    
    private func layout() {
        headerView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints{
            $0.leading.equalToSuperview().offset(8)
            $0.bottom.equalToSuperview().offset(-8)
            $0.trailing.lessThanOrEqualTo(button.snp.leading).offset(-8)
        }
        
        button.snp.makeConstraints{
            $0.centerY.equalTo(dateLabel)
            $0.trailing.equalToSuperview().offset(-8)
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
