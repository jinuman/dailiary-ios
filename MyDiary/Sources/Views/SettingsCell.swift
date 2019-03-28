//
//  SettingsCell.swift
//  MyDiary
//
//  Created by Jinwoo Kim on 28/03/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    var viewModel: SettingsCellViewModel? {
        didSet {
            handleCell(with: viewModel)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func handleCell(with viewModel: SettingsCellViewModel?) {
        guard let viewModel = viewModel else { return }
        
        self.textLabel?.text = viewModel.title
        self.textLabel?.font = viewModel.font
        self.accessoryType = viewModel.isChecked ? .checkmark : .none
    }
}
