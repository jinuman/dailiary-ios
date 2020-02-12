//
//  TimelineViewController.swift
//  MyDiary
//
//  Created by Jinwoo Kim on 27/03/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import UIKit

class TimelineViewController: UITableViewController {
    
    // MARK:- Properties
    var viewModel: TimelineViewModel?
    
    private let cellId = "timelineCellId"
    
    private let searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    // MARK:- Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavigationItems()
        setupSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.becomeFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        guard let viewModel = viewModel else { return }
        if searchController.isActive {
            viewModel.searchText = nil
            searchController.isActive = false
        }
    }
    
    // MARK:- Setup screen properties
    private func setupTableView() {
        tableView.register(TimelineCell.self, forCellReuseIdentifier: cellId)
        tableView.allowsSelection = true
        tableView.isUserInteractionEnabled = true
    }
    
    private func setupNavigationItems() {
        navigationItem.title = "타임라인"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(handleAdd))
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "baseline_settings_black_24pt"), style: .plain, target: self, action: #selector(showSettings))
    }
    
    private func setupSearchController() {
        definesPresentationContext = true
        
        searchController.searchBar.placeholder = "검색어로 일기를 찾아보세요.."
        searchController.searchBar.tintColor = .black
        searchController.searchBar.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.hidesNavigationBarDuringPresentation = false
        
        navigationItem.searchController = searchController
    }
    
    // MARK:- Handling methods
    @objc private func handleAdd() {
        guard let viewModel = viewModel else { return }
        let diaryViewController = DiaryViewController(viewModel: viewModel.newDiaryViewModel)
        self.navigationController?.pushViewController(diaryViewController, animated: true)
    }
    
    @objc private func showSettings() {
        guard let viewModel = viewModel else { return }
        let settingsController = SettingsController()
        settingsController.viewModel = viewModel.settingsViewModel
        
        let backItem = UIBarButtonItem()
        backItem.title = "뒤로"
        navigationItem.backBarButtonItem = backItem
        
        navigationController?.pushViewController(settingsController, animated: true)
    }
}

// MARK:- Regarding tableView methods
extension TimelineViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfRows(in: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? TimelineCell,
            let viewModel = viewModel else {
            fatalError("Timeline cell is bad")
        }
        cell.viewModel = viewModel.timelineCellViewModel(for: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let viewModel = viewModel else { return "" }
        return viewModel.headerTitle(of: section)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let viewModel = viewModel,
            let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
        
        let diaryViewModel = viewModel.diaryViewModel(for: selectedIndexPath)
        let diaryViewController = DiaryViewController(viewModel: diaryViewModel) // env 주입
        self.navigationController?.pushViewController(diaryViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard searchController.isActive == false else {
            return UISwipeActionsConfiguration(actions: [])
        }

        let removeAction = UIContextualAction(style: .normal, title:  nil) { [weak self] (action: UIContextualAction, view: UIView, success: (Bool) -> Void) in
            
            guard
                let self = self,
                let viewModel = self.viewModel else { return }
            let isLastDiaryInSection: Bool = viewModel.numberOfRows(in: indexPath.section) == 1
            viewModel.removeDiary(at: indexPath)
            
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
extension TimelineViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard
            let viewModel = viewModel,
            let searchText = searchController.searchBar.text else { return }
        
        viewModel.searchText = searchText
        tableView.reloadData()
    }
}
