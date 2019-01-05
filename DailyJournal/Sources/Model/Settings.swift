//
//  Settings.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2019. 1. 5..
//  Copyright © 2019년 jinuman. All rights reserved.
//

import UIKit

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

enum FontSizeOption: CGFloat, SettingsOption {
    case small = 14
    case medium = 16
    case large = 18
    
    static var name: String { return "글자 크기" }
    static var `default`: FontSizeOption { return .medium }
    static var all: [FontSizeOption] { return [.small, .medium, .large] }
}
