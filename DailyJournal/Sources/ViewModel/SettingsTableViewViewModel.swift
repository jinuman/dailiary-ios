//
//  SettingsTableViewViewModel.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2019. 1. 5..
//  Copyright © 2019년 jinuman. All rights reserved.
//

import UIKit

struct SettingsSectionModel {
    let title: String
    let cellModels: [SettingsCellModel]
}

struct SettingsCellModel {
    let title: String
    let font: UIFont
    let isChecked: Bool
}

class SettingsTableViewViewModel {
    let environment: Environment
    
    init(environment: Environment) {
        self.environment = environment
    }
    
    var sectionModels: [SettingsSectionModel] {
        let now = environment.now()
        
        return [
            SettingsSectionModel(
                title: DateFormatOption.name,
                cellModels: DateFormatOption.all.map { option in
                    SettingsCellModel(
                        title: DateFormatter.formatter(with: option.rawValue).string(from: now),
                        font: UIFont.systemFont(ofSize: UIFont.systemFontSize),
                        isChecked: option == DateFormatOption.default
                    )
                }
            ),
            SettingsSectionModel(
                title: FontSizeOption.name,
                cellModels: FontSizeOption.all.map { option in
                    SettingsCellModel(
                        title: "\(option)",
                        font: UIFont.systemFont(ofSize: option.rawValue),
                        isChecked: option == FontSizeOption.default
                    )
                }
            )
        ]
    }
}
