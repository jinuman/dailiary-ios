public extension Dictionary {
    static func + (lhs: Dictionary, rhs: Dictionary) -> Dictionary {
        var result = lhs
        rhs.forEach { result[$0.key] = $0.value }
        return result
    }
}

public extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

public extension Array where Element: Equatable {
    var removeDuplicates: Self {
        var result: [Element] = []
        for item in self {
            if !result.contains(item) {
                result.append(item)
            }
        }
        return result
    }
}

public extension Optional where Wrapped: Swift.Collection {
    var isNilOrEmpty: Bool {
        guard let self = self else { return true }
        return self.isEmpty != false
    }
}

public extension DateFormatter {
    static let fullISO8601: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
}
