//
//  TimelineViewModel.swift
//  MyDiary
//
//  Created by Jinwoo Kim on 27/03/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import UIKit

protocol TimelineViewModelDelegate: class {
    func didRemoveDiary()  // DiaryController 에서 삭제하면 이 메소드도 수행한다.
    func didAddDiary()     // 새로 추가한 일기인 상태에서, DiaryController 에서 저장하면 이 메소드도 수행한다.
}

class TimelineViewModel {
    
    // MARK:- Properties
    private let environment: Environment
    
    private var dates = [Date]()
    
    private var repo: DiaryRepository {
        return environment.diaryRepository
    }
    
    private var allDiaries: [Diary] {
        return repo.allDiaries
    }
    
    // 새로 추가하는 일기에 대한 ViewModel
    var newDiaryViewModel: DiaryViewModel {
        let vm = DiaryViewModel(environment: environment)
        vm.delegate = self
        return vm
    }
    
    lazy var settingsViewModel: SettingsViewModel = SettingsViewModel(environment: environment)
    
    private var filteredDiaries = [Diary]()
    
    var searchText: String? {
        didSet {
            guard let text = searchText else {
                self.filteredDiaries = []
                return
            }
            self.filteredDiaries = environment.diaryRepository.diary(has: text)
        }
    }
    
    var isSearching: Bool {
        return searchText?.isEmpty == false
    }
    
    // MARK:- Initializer
    init(environment: Environment) {
        self.environment = environment
        self.dates = repo.uniqueDates   // 유니크한 날짜만 있는 dates 초기화
    }
    
    // MARK:- Helper methods
    private func diaries(for date: Date) -> [Diary] {
        return self.allDiaries.filter {
            $0.createdAt.hmsRemoved == date
        }
    }
    
    private func diary(for indexPath: IndexPath) -> Diary {
        guard isSearching == false else {
            return filteredDiaries[indexPath.row]
        }
        
        let date = self.dates[indexPath.section]
        let diary = self.diaries(for: date)[indexPath.row]
        return diary
    }
    
    func timelineCellViewModel(for indexPath: IndexPath) -> TimelineCellViewModel {
        let diary = self.diary(for: indexPath)
        
        // 셀 채우기
        return TimelineCellViewModel(diaryText: diary.text,
                                     diaryTextFont: UIFont.systemFont(ofSize: environment.settings.fontSizeOption.rawValue),
                                     ampm: DateFormatter.ampmFormatter.string(from: diary.createdAt),
                                     clock: DateFormatter.clockFormatter.string(from: diary.createdAt))
    }
    
    func diaryViewModel(for indexPath: IndexPath) -> DiaryViewModel {
        let vm = DiaryViewModel(environment: environment, selectedDiary: diary(for: indexPath))
        vm.delegate = self
        return vm
    }
    
    func removeDiary(at indexPath: IndexPath) {
        let date = self.dates[indexPath.section]
        let diaries = self.diaries(for: date)
        let diaryToRemove = diaries[indexPath.row]
        repo.remove(diaryToRemove)
        
        if diaries.count == 1 {
            self.dates = self.dates.filter {
                $0 != date
            }
//            self.dates = repo.uniqueDates  // 이렇게 해도 된다.
        }
    }
}

// MARK:- Regarding Timeline tableView methods
extension TimelineViewModel {
    func numberOfRows(in section: Int) -> Int {
        guard isSearching == false else {
            return filteredDiaries.count
        }
        let date = self.dates[section]
        return diaries(for: date).count
    }
    
    var numberOfSections: Int {
        return isSearching ? 1 : self.dates.count
    }
    
    func headerTitle(of section: Int) -> String? {
        guard isSearching == false else { return nil }
        
        let date = self.dates[section]
        return DateFormatter.formatter(with: environment.settings.dateFormatOption.rawValue).string(from: date)
    }
}

// MARK:- Regarding custom TimelineViewModelDelegate methods
extension TimelineViewModel: TimelineViewModelDelegate {
    func didRemoveDiary() {
        self.dates = repo.uniqueDates    // 하나 남은 일기 없앨 때, 날짜도 없앤다.
    }
    
    func didAddDiary() {
        self.dates = repo.uniqueDates    // 날짜를 수정해준다.
    }
}

