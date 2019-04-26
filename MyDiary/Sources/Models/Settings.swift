//
//  Settings.swift
//  MyDiary
//
//  Created by Jinwoo Kim on 28/03/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import UIKit

protocol Settings {
    var dateFormatOption: DateFormatOption { get set }
    var fontSizeOption: FontSizeOption { get set }
}

// env 에 주입시킬 세팅
class InMemorySettings: Settings {
    var dateFormatOption: DateFormatOption = .default
    var fontSizeOption: FontSizeOption = .default
}

protocol SettingsOption {
    static var title: String { get }
    static var `default`: Self { get }
    static var all: [Self] { get }
}

enum DateFormatOption: String, SettingsOption {
    case yearFirst = "yyyy. MM. dd. EEE"
    case dayOfWeekFirst = "EEE, MMM d, yyyy"
    
    static var title: String {
        return "날짜 표현"
    }
    static var `default`: DateFormatOption {
        return .yearFirst
    }
    
    static var all: [DateFormatOption] {
        return [.yearFirst, .dayOfWeekFirst]
    }
}

enum FontSizeOption: CGFloat, SettingsOption {
    case small = 12
    case medium = 16
    case large = 20
    
    static var title: String {
        return "글자 크기"
    }
    static var `default`: FontSizeOption {
        return .medium
    }
    
    static var all: [FontSizeOption] {
        return [.small, .medium, .large]
    }
    
    var description: String {
        switch self {
        case .small: return "작게"
        case .medium: return "중간"
        case .large: return "크게"
        }
    }
}

// MARK:- For UI
extension Settings {
    func sectionModels(with now: Date) -> [SettingsSectionModel] {
        return [
            SettingsSectionModel(
                title: DateFormatOption.title,
                options: DateFormatOption.all.map {
                    Option(name: DateFormatter.formatter(with: $0.rawValue).string(from: now),
                           font: UIFont.systemFont(ofSize: UIFont.systemFontSize),
                           isChecked: $0 == dateFormatOption)
                }
            ),
            SettingsSectionModel(
                title: FontSizeOption.title,
                options: FontSizeOption.all.map {
                    Option(name: $0.description,
                           font: UIFont.systemFont(ofSize: $0.rawValue),
                           isChecked: $0 == fontSizeOption)
                }
            )
        ]
    }
}


