//
//  TimelineController.swift
//  MyDiary
//
//  Created by Jinwoo Kim on 27/03/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import UIKit

class TimelineController: UITableViewController {
    
    // MARK:- Properties
    private let timelineCellId = "timelineCellId"
    
    var viewModel: TimelineViewModel!   // viewModel = nil 이면 env 주입에서 뭔가 문제가 생긴 것이다.
    
    private let searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    // MARK:- Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "타임라인"
        
        setupSearchController()
        definesPresentationContext = true
        
        tableView.register(TimelineCell.self, forCellReuseIdentifier: timelineCellId)
        
        tableView.allowsSelection = true
        tableView.isUserInteractionEnabled = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_settings_black_24pt"), style: .plain, target: self, action: #selector(showSettings))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if searchController.isActive {
            viewModel.searchText = nil
            searchController.isActive = false
        }
    }
    
    // MARK:- Handling methods
    @objc fileprivate func handleAdd() {
        let diaryVC = DiaryController()
        diaryVC.viewModel = viewModel.newDiaryViewModel
        navigationController?.pushViewController(diaryVC, animated: true)
    }
    
    @objc fileprivate func showSettings() {
        let settingsVC = SettingsController()
        settingsVC.viewModel = viewModel.settingsViewModel
        
        let backItem = UIBarButtonItem()
        backItem.title = "뒤로"
        navigationItem.backBarButtonItem = backItem
        
        navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    fileprivate func setupSearchController() {
        searchController.searchBar.placeholder = "검색어로 일기를 찾아보세요.."
        searchController.searchBar.tintColor = .black
        searchController.searchBar.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        
        navigationItem.searchController = searchController
    }
}

// MARK:- Regarding tableView methods
extension TimelineController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: timelineCellId, for: indexPath) as? TimelineCell else {
            fatalError("Timeline cell is bad")
        }
        cell.viewModel = viewModel.timelineCellViewModel(for: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.headerTitle(of: section)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
        let diaryVC = DiaryController()
        diaryVC.viewModel = viewModel.diaryViewModel(for: selectedIndexPath)    // env 주입
        navigationController?.pushViewController(diaryVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard searchController.isActive == false else {
            return UISwipeActionsConfiguration(actions: [])
        }
        
        let removeAction = UIContextualAction(style: .normal, title:  nil) { (action: UIContextualAction, view: UIView, success: (Bool) -> Void) in
            
            let isLastDiaryInSection: Bool = self.viewModel.numberOfRows(in: indexPath.section) == 1
            self.viewModel.removeDiary(at: indexPath)
            
            UIView.animate(withDuration: 0.3) {
                tableView.beginUpdates()
                if isLastDiaryInSection {
                    tableView.deleteSections(IndexSet.init(integer: indexPath.section), with: .automatic)
                } else {
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
                tableView.endUpdates()
            }
            success(true)
        }
        
        removeAction.image = #imageLiteral(resourceName: "baseline_delete_white_24pt")
        removeAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [removeAction])
    }
}

// MARK:- Regarding UISearchResultsUpdating methods
extension TimelineController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        viewModel.searchText = searchText
        tableView.reloadData()
    }
}
