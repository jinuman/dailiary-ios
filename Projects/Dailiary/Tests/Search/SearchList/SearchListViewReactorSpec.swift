//
//  SearchListViewReactorSpec.swift
//  DailiaryTests
//
//  Created by Jinwoo Kim on 2021/03/15.
//

import DailiaryTest
import DailiaryReactive
import DailiaryFoundation
@testable import Dailiary

final class SearchListViewReactorSpec: QuickSpec {
    override func spec() {
        func createReactor(
            searchService: SearchServiceType = SearchServiceMock(),
            userDefaults: UserDefaults = UserDefaultsMock()
        ) -> SearchListViewReactor {
            let factory = SearchListViewReactor.Factory(dependency: .init(
                searchService: searchService,
                userDefaults: userDefaults
            ))
            return factory.create()
        }

        context(".refresh 액션 이벤트를 받으면") {
            it("필터 타입이 ALL 이면 블로그, 카페 데이터를 둘 다 불러옵니다.") {
                // given
                let searchService = SearchServiceMock()
                searchService.registerResult(for: searchService.fetchBlogsReference) { args in
                    return .just([DocumentFixture.blogNormal])
                }
                searchService.registerResult(for: searchService.fetchCafesReference) { args in
                    return .just([DocumentFixture.cafeNormal])
                }
                let reactor = createReactor(searchService: searchService)

                // when
                reactor.action.onNext(.refresh)

                // then
                expect(searchService.hasCalled(searchService.fetchBlogsReference)) == true
                expect(searchService.hasCalled(searchService.fetchCafesReference)) == true
                expect(reactor.currentState.sections.last?.items).to(haveCount(2))
            }

            it("isRefreshing 상태를 변경합니다.") {
                // given
                let searchService = SearchServiceMock()
                searchService.registerResult(for: searchService.fetchBlogsReference) { args in
                    return .just([DocumentFixture.blogNormal])
                }
                searchService.registerResult(for: searchService.fetchCafesReference) { args in
                    return .just([DocumentFixture.cafeNormal])
                }
                let reactor = createReactor(searchService: searchService)

                let disposeBag = DisposeBag()
                var isRefreshingHistory: [Bool] = []

                reactor.state.map { $0.isRefreshing }
                    .distinctUntilChanged()
                    .subscribe(onNext: {
                        isRefreshingHistory.append($0)
                    })
                    .disposed(by: disposeBag)

                // when
                reactor.action.onNext(.refresh)

                // then
                expect(isRefreshingHistory) == [false, true, false]
            }
        }
    }
}

extension Factory where Module == SearchListViewReactor {
    static func dummy() -> Factory {
        return .init(dependency: .init(
            searchService: SearchServiceMock(),
            userDefaults: UserDefaultsMock()
        ))
    }
}
