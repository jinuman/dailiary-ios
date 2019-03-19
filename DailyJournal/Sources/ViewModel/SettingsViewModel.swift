//
//  SettingsViewModel.swift
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

class SettingsViewModel {
    let environment: Environment
    
    init(environment: Environment) {
        self.environment = environment
    }
    
    var sectionModels: [SettingsSectionModel] {
        let now = environment.now()
        return environment.settings.sectionModels(with: now)
    }
    
    func selectOption(for indexPath: IndexPath) {
        switch indexPath.section {
        case 0:     // 날짜 크기 변경
            let newOption = DateFormatOption.all[indexPath.row]
            environment.settings.dateFormatOption = newOption
        case 1:     // 폰트 크기 변경
            let newOption = FontSizeOption.all[indexPath.row]
            environment.settings.fontSizeOption = newOption
        default:
            break
        }
    }
}
