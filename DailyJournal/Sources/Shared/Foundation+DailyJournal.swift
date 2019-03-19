//
//  Foundation+DailyJournal.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 12. 19..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import Foundation

extension DateFormatter {
    static func formatter(with format: String) -> DateFormatter {
        let df = DateFormatter()
        df.dateFormat = format
        return df
    }
    
    static var journalDateFormatter: DateFormatter = DateFormatter.formatter(with: "yyyy. MM. dd. EEE")
    static var ampmFormatter: DateFormatter = DateFormatter.formatter(with: "a")
    static var journalTimeFormatter: DateFormatter = DateFormatter.formatter(with: "h:mm")
}

extension Date {
    static func before(_ days: Int) -> Date {
        let timeInterval = Double(days) * 24 * 60 * 60
        return Date(timeIntervalSinceNow: -timeInterval)
    }
    
    var hmsRemoved: Date? {
        return Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: self)
    }
}

extension Array where Element: Hashable {
    func unique() -> [Element] {
        var result: [Element] = []
        
        for item in self {
            if result.contains(item) == false {
                result.append(item)
            }
        }
        return result
    }
}
