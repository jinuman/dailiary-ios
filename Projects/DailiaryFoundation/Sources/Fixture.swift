public func fixture<T: Codable>(_ jsonString: String) -> T {
    do {
        guard let data = jsonString.data(using: .utf8) else {
            fatalError("FAILED: JSON to data")
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .formatted(DateFormatter.fullISO8601)
        return try decoder.decode(T.self, from: data)
    } catch let error {
        fatalError(error.localizedDescription)
    }
}
