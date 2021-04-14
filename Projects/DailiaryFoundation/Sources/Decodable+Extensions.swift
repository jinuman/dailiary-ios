public extension String {
    static func decode<T: CodingKey>(
        _ container: KeyedDecodingContainer<T>,
        key: T
    ) -> String? {
        guard let rawString = try? container.decode(String.self, forKey: key) else { return nil }

        /// HTML 태그, Character code 공백처리
        let refinedString = rawString
            .replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
            .replacingOccurrences(of: "&[^;]+;", with: "", options: .regularExpression, range: nil)
        return refinedString
    }
}

public extension URL {
    static func decode<T: CodingKey>(
        _ values: KeyedDecodingContainer<T>,
        key: T
    ) -> URL? {
        guard let urlString = try? values.decode(String.self, forKey: key),
              let url = URL(string: urlString) else { return nil }
        return url
    }
}

public extension Date {
    static func decode<T: CodingKey>(
        _ container: KeyedDecodingContainer<T>,
        key: T
    ) -> Date? {
        let formatter = DateFormatter.fullISO8601
        guard let dateString = try? container.decode(String.self, forKey: key),
              let date = formatter.date(from: dateString) else { return nil }
        return date
    }
}
