//
//  DiaryRepository.swift
//  MyDiary
//
//  Created by Jinwoo Kim on 27/03/2019.
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

class InMemoryDiaryRepository: DiaryRepository {
    private var diaries: [UUID : Diary]
    
    var numberOfDiaries: Int {
        return diaries.count
    }
    
    init(diaries: [Diary] = []) {
        var result = [UUID : Diary]()
        
        diaries.forEach {
            result[$0.id] = $0
        }
        
        self.diaries = result
    }
    
    // Singleton property
    static var shared: InMemoryDiaryRepository = InMemoryDiaryRepository()
    
    func add(_ diary: Diary) {
        diaries[diary.id] = diary
    }
    
    func update(_ diary: Diary) {
        diaries[diary.id] = diary
    }
    
    func remove(_ diary: Diary) {
        diaries[diary.id] = nil
    }
    
    func diary(with id: UUID) -> Diary? {
        return diaries[id]
    }
    
    func recentDiaries(max: Int) -> [Diary] {
        guard max >= 0 else { return [] }
        
        let result = diaries.values
            .sorted { $0.createdAt > $1.createdAt }  // 내림차순
            .prefix(max)    // max 만큼 뽑기
        
        return Array(result)
    }
    
    func diary(has text: String) -> [Diary] {
        let result = diaries.values
            .filter { $0.text.contains(text) }
            .sorted { $0.createdAt > $1.createdAt }
        
        return Array(result)
    }
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

