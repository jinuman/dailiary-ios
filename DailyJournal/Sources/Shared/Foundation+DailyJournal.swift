//
//  Foundation+DailyJournal.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 12. 19..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import Foundation

extension DateFormatter {
    static var entryDateFormatter: DateFormatter = { () -> DateFormatter in
        let df = DateFormatter()
        df.dateFormat = "yyyy. MM. dd. EEE"
        return df
    }()
    
    static var ampmFormatter: DateFormatter = { () -> DateFormatter in
        let df = DateFormatter()
        df.dateFormat = "a"
        return df
    }()
    
    static var entryTimeFormatter: DateFormatter = { () -> DateFormatter in
        let df = DateFormatter()
//        df.timeStyle = .short
//        df.dateStyle = .short
        df.dateFormat = "h:mm"
        return df
    }()
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
