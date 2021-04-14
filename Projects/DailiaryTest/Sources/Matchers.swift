//
//  Matchers.swift
//  DailiaryTests
//
//  Created by Jinwoo Kim on 2021/03/18.
//

public extension Expectation {
    func to<U>(
        _ matcher: (@escaping (T) -> U) -> Predicate<T>,
        _ predicate: @escaping (T) -> U
    ) {
        self.to(matcher(predicate))
    }

    func to<U>(
        _ matcher: (@escaping (T.Iterator.Element) -> U) -> Predicate<T>,
        _ predicate: @escaping (T.Iterator.Element) -> U
    ) where T: Sequence {
        self.to(matcher(predicate))
    }

    func toEventually<U>(
        _ matcher: (@escaping (T) -> U) -> Predicate<T>,
        timeout: DispatchTimeInterval = AsyncDefaults.timeout,
        pollInterval: DispatchTimeInterval = AsyncDefaults.pollInterval,
        description: String? = nil,
        _ predicate: @escaping (T) -> U
    ) {
        self.toEventually(matcher(predicate), timeout: timeout, pollInterval: pollInterval, description: description)
    }

    func toEventually<U>(
        _ matcher: (@escaping (T.Iterator.Element) -> U) -> Predicate<T>,
        timeout: DispatchTimeInterval = AsyncDefaults.timeout,
        pollInterval: DispatchTimeInterval = AsyncDefaults.pollInterval,
        description: String? = nil,
        _ predicate: @escaping (T.Iterator.Element) -> U
    ) where T: Sequence {
        self.toEventually(matcher(predicate), timeout: timeout, pollInterval: pollInterval, description: description)
    }
}

public func match<T>(_ closure: @escaping (T) -> Bool) -> Predicate<T> {
    return Predicate { actualExpression in
        guard let actualValue = try actualExpression.evaluate() else {
            return PredicateResult(status: .fail, message: .fail("Found nil"))
        }
        return PredicateResult(
            status: closure(actualValue) ? .matches : .doesNotMatch,
            message: .fail("got <\(actualValue)>")
        )
    }
}

public func contain<T>(_ closure: @escaping (T.Iterator.Element) -> Bool) -> Predicate<T> where T: Sequence {
    return Predicate { actualExpression in
        guard let actualValue = try actualExpression.evaluate() else {
            return PredicateResult(status: .fail, message: .fail("Found nil"))
        }
        return PredicateResult(
            bool: actualValue.contains(where: closure),
            message: .fail("got <\(actualValue)>")
        )
    }
}

public func haveCount<T>(_ expectedCount: Int) -> (@escaping (T.Iterator.Element) -> Bool) -> Predicate<T> where T: Collection {
    return { closure in
        return Predicate { actualExpression in
            guard let actualValue = try actualExpression.evaluate() else {
                return PredicateResult(status: .fail, message: .fail("Found nil"))
            }
            let actualCount = actualValue.lazy.filter(closure).count
            let result = actualCount == expectedCount
            let message = ExpectationMessage.expectedCustomValueTo(
                "have \(prettyCollectionType(actualValue)) with count \(stringify(expectedCount))",
                actual: "\(actualCount)"
            )
            return PredicateResult(bool: result, message: message)
        }
    }
}
