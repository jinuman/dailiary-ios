//
//  DiaryRepository.swift
//  MyDiary
//
//  Created by Jinwoo Kim on 27/03/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import Foundation

class InMemoryDiaryRepository: DiaryRepository {
    
    static var shared: InMemoryDiaryRepository = InMemoryDiaryRepository()
    
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
