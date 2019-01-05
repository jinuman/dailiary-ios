//
//  Settings.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2019. 1. 5..
//  Copyright © 2019년 jinuman. All rights reserved.
//

import UIKit

protocol Settings {
    var dateFormatOption: DateFormatOption { get set }
    var fontSizeOption: FontSizeOption { get set }
}

class InMemorySettings: Settings {
    var dateFormatOption: DateFormatOption = .default
    var fontSizeOption: FontSizeOption = .default
}

protocol SettingsOption {
    static var name: String { get }
    static var `default`: Self { get }
    static var all: [Self] { get }
}

enum DateFormatOption: String, SettingsOption {
    case yearFirst = "yyyy. MM. dd. EEE"
    case dayOfWeekFirst = "EEE, MMM d, yyyy"
    
    static var name: String { return "날짜 표현" }
    static var `default`: DateFormatOption { return .yearFirst }
    static var all: [DateFormatOption] { return [.yearFirst, .dayOfWeekFirst] }
}

enum FontSizeOption: CGFloat, SettingsOption, CustomStringConvertible {
    case small = 14
    case medium = 16
    case large = 18
    
    static var name: String { return "글자 크기" }
    static var `default`: FontSizeOption { return .medium }
    static var all: [FontSizeOption] { return [.small, .medium, .large] }
    
    var description: String {
        switch self {
        case .small: return "작게"
        case .medium: return "중간"
        case .large: return "크게"
        }
    }
}

extension Settings {
    func sectionModels(with now: Date) -> [SettingsSectionModel] {
        return [
            SettingsSectionModel(
                title: DateFormatOption.name,
                cellModels: DateFormatOption.all.map { option in
                    SettingsCellModel(
                        title: DateFormatter.formatter(with: option.rawValue).string(from: now),
                        font: UIFont.systemFont(ofSize: UIFont.systemFontSize),
                        isChecked: option == dateFormatOption
                    )
                }
            ),
            SettingsSectionModel(
                title: FontSizeOption.name,
                cellModels: FontSizeOption.all.map { option in
                    SettingsCellModel(
                        title: option.description,
                        font: UIFont.systemFont(ofSize: option.rawValue),
                        isChecked: option == fontSizeOption
                    )
                }
            )
        ]
    }
}
