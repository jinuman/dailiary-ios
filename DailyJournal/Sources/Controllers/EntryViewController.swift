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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.font = UIFont.systemFont(ofSize: 40)
        textView.text = longtxt
    }

}
