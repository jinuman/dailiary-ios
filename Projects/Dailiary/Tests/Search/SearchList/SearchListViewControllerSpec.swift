//
//  SearchListViewControllerSpec.swift
//  DailiaryTests
//
//  Created by Jinwoo Kim on 2021/03/15.
//

import DailiaryTest
import DailiaryUI
@testable import Dailiary

final class SearchListViewControllerSpec: QuickSpec {
    override func spec() {
        var reactor: SearchListViewReactor!

        beforeEach {
            reactor = createReactor()
        }

        func createReactor() -> SearchListViewReactor {
            let reactor = SearchListViewReactor.Factory.dummy().create()
            reactor.isStubEnabled = true
            return reactor
        }

        func createViewController() -> SearchListViewController {
            let factory = SearchListViewController.Factory.init(dependency: .init(
                searchDetailViewReactorFactory: .dummy(),
                searchDetailViewControllerFactory: .dummy()
            ))
            let viewController = factory.create(payload: .init(reactor: reactor))
            viewController.loadViewIfNeeded()
            return viewController
        }

        context("뷰가 로드되었을 때") {
            it("타이틀을 표시합니다.") {
                // given
                let viewController = createViewController()

                // then
                expect(viewController.title) == "검색"
            }

            it(".refresh 액션 이벤트를 전달합니다.") {
                // given
                _ = createViewController()

                // then
                expect(reactor.stub.actions.last).to(match) {
                    guard case .refresh = $0 else { return false }
                    return true
                }
            }
        }

        context("세로로 스크롤해서 컨텐츠 끝에 가까이 도달했을 때") {
            it(".loadMore 액션 이벤트를 전달합니다.") {
                // given

                // when

                // then
            }
        }

        describe("searchBar (검색바)") {
            it("superview 는 viewController 의 view 입니다.") {
                // given
                let viewController = createViewController()
                let searchBar = viewController.testables[\.searchBar]

                // then
                expect(searchBar.superview) == viewController.view
            }

            it("검색어를 입력해서 검색하면 .search 액션 이벤트를 전달합니다.") {
                // given
                let viewController = createViewController()
                let searchKeywordRelay = viewController.testables[\.searchKeywordRelay]

                // when
                searchKeywordRelay.accept("검색어")

                // then
                expect(reactor.stub.actions.last).to(match) {
                    guard case let .search(keyword) = $0 else { return false }
                    return keyword == "검색어"
                }
            }
        }

        describe("tableView (검색한 결과를 보여주는 목록 테이블뷰)") {
            it("superview 는 viewController 의 view 입니다.") {
                // given
                let viewController = createViewController()
                let tableView = viewController.testables[\.tableView]

                // then
                expect(tableView.superview) == viewController.view
            }
        }

        describe("searchHistoryView (검색 내역 뷰)") {
            it("superview 는 viewController 의 view 입니다.") {
                // given
                let viewController = createViewController()
                let searchHistoryView = viewController.testables[\.searchHistoryView]

                // then
                expect(searchHistoryView.superview) == viewController.view
            }

            it("처음에는 보여주지 않습니다.") {
                // given
                let viewController = createViewController()
                let searchHistoryView = viewController.testables[\.searchHistoryView]

                // then
                expect(searchHistoryView.isHidden) == true
            }
        }

        describe("activityIndicatorView") {
            it("superview 는 viewController 의 view 입니다.") {
                // given
                let viewController = createViewController()
                let activityIndicatorView = viewController.testables[\.activityIndicatorView]

                // then
                expect(activityIndicatorView.superview) == viewController.view
            }

            it("처음에는 동작하지 않습니다.") {
                // given
                let viewController = createViewController()
                let activityIndicatorView = viewController.testables[\.activityIndicatorView]

                // then
                expect(activityIndicatorView.isAnimating) == false
            }

            it("Reactor 의 isRefreshing 의 상태에 따라 동작합니다.") {
                // given
                let viewController = createViewController()
                let activityIndicatorView = viewController.testables[\.activityIndicatorView]

                // when
                reactor.stub.state.value.isRefreshing = true

                // then
                expect(activityIndicatorView.isAnimating) == true
            }
        }
    }
}

extension Factory where Module == SearchListViewController {
    static func dummy() -> Factory {
        return .init(dependency: .init(
            searchDetailViewReactorFactory: .dummy(),
            searchDetailViewControllerFactory: .dummy()
        ))
    }
}
