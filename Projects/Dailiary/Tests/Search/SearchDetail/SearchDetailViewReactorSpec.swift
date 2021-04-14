//
//  SearchDetailViewReactorSpec.swift
//  DailiaryTests
//
//  Created by Jinwoo Kim on 2021/03/28.
//

import DailiaryTest
import DailiaryFoundation
@testable import Dailiary

final class SearchDetailViewReactorSpec: QuickSpec {
    override func spec() {
    }
}

extension Factory where Module == SearchDetailViewReactor {
    static func dummy() -> Factory {
        return .init(dependency: .init(
            userDefaults: UserDefaultsMock()
        ))
    }
}
