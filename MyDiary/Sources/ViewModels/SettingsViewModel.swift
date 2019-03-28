//
//  SettingsViewModel.swift
//  MyDiary
//
//  Created by Jinwoo Kim on 28/03/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import UIKit

struct SettingsSectionModel {
    let title: String
    let settings: [Option]
}

class SettingsViewModel {
    // MARK:- Properties
    private let environment: Environment
    
    var sectionModels: [SettingsSectionModel] {
        let now = environment.now()
        return environment.settings.sectionModels(with: now)
    }
    
    var numberOfSections: Int {
        return self.sectionModels.count
    }
    
    // MARK:- Initializer
    init(environment: Environment) {
        self.environment = environment
    }
    
    // MARK:- Helper methods
    private func setting(for indexPath: IndexPath) -> Option {
        return self.sectionModels[indexPath.section].settings[indexPath.row]
    }
    
    func settingsCellViewModel(for indexPath: IndexPath) -> SettingsCellViewModel {
        let setting = self.setting(for: indexPath)
        
        // Setting 셀 채우기
        return SettingsCellViewModel(title: setting.title,
                                     font: setting.font,
                                     isChecked: setting.isChecked)
    }
    
    func numberOfRows(in section: Int) -> Int {
        return self.sectionModels[section].settings.count
    }
    
    func headerTitle(of section: Int) -> String {
        return self.sectionModels[section].title
    }
    
    func selectOption(for indexPath: IndexPath) {
        switch indexPath.section {
        case 0:     // 날짜 표현 변경
            let newOption = DateFormatOption.all[indexPath.row]
            environment.settings.dateFormatOption = newOption
        case 1:     // 글자 크기 변경
            let newOption = FontSizeOption.all[indexPath.row]
            environment.settings.fontSizeOption = newOption
        default:
            break
        }
    }
    
}


