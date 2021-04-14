//
//  SearchServiceMock.swift
//  DailiaryTests
//
//  Created by Jinwoo Kim on 2021/03/17.
//

import DailiaryTest
import DailiaryReactive
@testable import Dailiary

final class SearchServiceMock: Mock, SearchServiceType {
    lazy var fetchBlogsReference = MockReference(fetchBlogs)
    func fetchBlogs(with query: String, page: Int, perPage: Int) -> Single<[Document]> {
        call(fetchBlogsReference, args: (query, page, perPage), fallback: .never())
    }

    lazy var fetchCafesReference = MockReference(fetchCafes)
    func fetchCafes(with query: String, page: Int, perPage: Int) -> Single<[Document]> {
        call(fetchCafesReference, args: (query, page, perPage), fallback: .never())
    }
}


// MARK: - Stubber version
/// MockingKit 과 동일하게 동작하는지 테스트해보기 위해 임의로 작성

final class SearchServiceStub: SearchServiceType {
    lazy var fetchBlogsReference = FunctionStub(fetchBlogs)
    func fetchBlogs(with query: String, page: Int, perPage: Int) -> Single<[Document]> {
        return Stubber.invoke(fetchBlogsReference, args: (query, page, perPage), default: .never())
    }

    lazy var fetchCafesReference = FunctionStub(fetchCafes)
    func fetchCafes(with query: String, page: Int, perPage: Int) -> Single<[Document]> {
        return Stubber.invoke(fetchCafesReference, args: (query, page, perPage), default: .never())
    }
}
