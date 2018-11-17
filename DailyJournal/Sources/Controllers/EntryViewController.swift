//
//  EntryViewController.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 11. 17..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit
import SnapKit

class EntryViewController: UIViewController {
    let headerView: UIView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubviews()
        layout()
        
        headerView.backgroundColor = UIColor.init(red: 0.909, green: 0.510, blue: 0.488, alpha: 1.0)
    }
    
    private func addSubviews() {
        view.addSubview(headerView)
    }
    
    private func layout() {
        headerView.snp.makeConstraints {
            $0.leading.top.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
    }
    
    
}
