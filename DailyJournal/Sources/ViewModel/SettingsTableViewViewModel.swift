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
        return []
    }
}
