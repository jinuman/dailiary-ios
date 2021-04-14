//
//  SearchDetailViewControllerSpec.swift
//  DailiaryTests
//
//  Created by Jinwoo Kim on 2021/03/28.
//

import DailiaryTest
import DailiaryUI
@testable import Dailiary

final class SearchDetailViewControllerSpec: QuickSpec {
    override func spec() {
        var reactor: SearchDetailViewReactor!

        beforeEach {
            reactor = createReactor()
        }

        func createReactor() -> SearchDetailViewReactor {
            let reactor = SearchDetailViewReactor.Factory.dummy().create(payload: .init(
                document: DocumentFixture.blogNormal
            ))
            reactor.isStubEnabled = true
            return reactor
        }

        func createViewController() -> SearchDetailViewController {
            let factory = SearchDetailViewController.Factory.init(dependency: .init())
            let viewController = factory.create(payload: .init(reactor: reactor))
            viewController.loadViewIfNeeded()
            return viewController
        }
    }
}

extension Factory where Module == SearchDetailViewController {
    static func dummy() -> Factory {
        return .init(dependency: .init())
    }
}
