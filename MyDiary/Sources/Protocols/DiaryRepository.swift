//
//  DiaryRepository.swift
//  MyDiary
//
//  Created by Jinwoo Kim on 07/09/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import Foundation

protocol DiaryRepository {
    var numberOfDiaries: Int { get }
    
    func add(_ diary: Diary)                    // 생성
    func update(_ diary: Diary)                 // 수정
    func remove(_ diary: Diary)                 // 삭제
    func diary(with id: UUID) -> Diary?         // 아이디로 조회
    func recentDiaries(max: Int) -> [Diary]     // 최근 일기들 불러오기
    func diary(has text: String) -> [Diary]     // 검색된 결과 리턴
}

extension DiaryRepository {
    var allDiaries: [Diary] {
        return recentDiaries(max: numberOfDiaries)
    }
    
    var uniqueDates: [Date] {
        return allDiaries
            .compactMap { $0.createdAt.hmsRemoved }
            .unique()
    }
}
