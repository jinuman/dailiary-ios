//
//  Settings.swift
//  MyDiary
//
//  Created by Jinwoo Kim on 07/09/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import UIKit

protocol Settings {
    var dateFormatOption: DateFormatOption { get set }
    var fontSizeOption: FontSizeOption { get set }
}

// MARK:- For UI
extension Settings {
    func sectionModels(with now: Date) -> [SettingsSectionModel] {
        return [
            SettingsSectionModel(
                title: DateFormatOption.title,
                options: DateFormatOption.all.map { (option: DateFormatOption) in
                    let font = UIFont(name: "HoonMakdR", size: UIFont.systemFontSize) ?? UIFont.systemFont(ofSize: 14)
                    return Option(name: DateFormatter.formatter(with: option.rawValue).string(from: now),
                                  font: font,
                                  isChecked: option == dateFormatOption)
                }
            ),
            SettingsSectionModel(
                title: FontSizeOption.title,
                options: FontSizeOption.all.map { (option: FontSizeOption) in
                    Option(name: option.description,
                           font: UIFont(name: "HoonMakdR", size: option.rawValue) ?? UIFont.systemFont(ofSize: option.rawValue),
                           isChecked: option == fontSizeOption)
                }
            )
        ]
    }
}

protocol SettingsOption {
    static var title: String { get }
    static var `default`: Self { get }
    static var all: [Self] { get }
}
