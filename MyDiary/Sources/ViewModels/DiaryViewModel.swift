//
//  DiaryViewModel.swift
//  MyDiary
//
//  Created by Jinwoo Kim on 28/03/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import UIKit

// Timeline 부분과 통신한다.
protocol DiaryViewModelDelegate: class {
    func didRemoveDiary()
    func didAddDiary()
}

class DiaryViewModel {
    
    // MARK:- Helper properties
    private let environment: Environment
    
    private var repo: DiaryRepository {
        return environment.diaryRepository
    }
    
    private var diary: Diary?   // 현재 상태의 일기
    
    weak var delegate: DiaryViewModelDelegate?
    
    var hasDiary: Bool {
        return diary != nil
    }
    
    // internal getter, private setter
    private(set) var isEditing: Bool = false
    
    var diaryTitle: String {
        let date = diary?.createdAt ?? environment.now()
        return DateFormatter.formatter(with: environment.settings.dateFormatOption.rawValue).string(from: date)
    }
    
    var diaryTextViewText: String? {
        return diary?.text
    }
    
    var diaryTextViewFont: UIFont {
        return UIFont.systemFont(ofSize: environment.settings.fontSizeOption.rawValue)
    }
    
    var saveEditButtonImage: UIImage {
        return isEditing ? #imageLiteral(resourceName: "baseline_save_black_24pt") : #imageLiteral(resourceName: "baseline_edit_black_24pt")
    }
    
    var removeButtonEnabled: Bool {
        return hasDiary
    }
    
    var diaryTextViewEditable: Bool {
        return isEditing
    }
    
    // MARK:- Initializer
    init(environment: Environment, selectedDiary: Diary? = nil) {
        self.environment = environment
        self.diary = selectedDiary
    }
    
    // MARK:- Helper methods
    // Editing 시작한다.
    func startEditing() {
        isEditing = true
    }
    
    func completeEditing(with text: String) {
        isEditing = false
        
        if let completedDiary = diary {  // 수장하는 일기라면,
            completedDiary.text = text
            repo.update(completedDiary)
        } else {                         // 새로 추가하는 일기라면,
            let newDiary = Diary(text: text)
            repo.add(newDiary)
            self.diary = newDiary
            self.delegate?.didAddDiary()
        }
    }
    
    func removeDiary() -> Diary? {
        guard let diaryToRemove = diary else { return nil }
        repo.remove(diaryToRemove)
        self.diary = nil
        self.delegate?.didRemoveDiary() // 섹션 헤더 날짜도 없앤다.
        return diaryToRemove
    }
}
