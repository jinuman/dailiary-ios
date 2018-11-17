//
//  EntryViewController.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 11. 17..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit
import SnapKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        layout()
        
        headerView.backgroundColor = UIColor.init(red: 0.909, green: 0.510, blue: 0.488, alpha: 1.0)
        textView.text = tmpTxt
        textView.font = UIFont.systemFont(ofSize: 50)
    }
    
    private func addSubviews() {
        view.addSubview(headerView)
        view.addSubview(textView)
    }
    
    private func layout() {
        headerView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
}
