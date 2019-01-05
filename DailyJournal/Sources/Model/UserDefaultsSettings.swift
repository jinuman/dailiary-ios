//
//  UserDefaultsSettings.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2019. 1. 5..
//  Copyright © 2019년 jinuman. All rights reserved.
//

import UIKit

private let dateFormatOptionKey: String = "dateFormatOptionKey"
private let fontSizeOptionKey: String = "fontSizeOptionKey"

extension UserDefaults: Settings {
    var dateFormatOption: DateFormatOption {
        get {
            let rawValue = object(forKey: dateFormatOptionKey) as? String
            return rawValue.flatMap(DateFormatOption.init) ?? .default
        }
        set {
            set(newValue.rawValue, forKey: dateFormatOptionKey)
            synchronize()
        }
    }
    
    var fontSizeOption: FontSizeOption {
        get {
            let rawValue = object(forKey: fontSizeOptionKey) as? CGFloat
            if
                let rawValue = rawValue,
                let option = FontSizeOption(rawValue: rawValue) {
                return option
            } else {
                return FontSizeOption.default
            }
        }
        set {
            set(newValue.rawValue, forKey: fontSizeOptionKey)
            synchronize()
        }
    }
}
