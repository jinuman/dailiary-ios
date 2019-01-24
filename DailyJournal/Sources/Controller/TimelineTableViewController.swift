//
//  TimelineTableViewController.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 12. 19..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit

class TimelineTableViewController: UIViewController {
    
    @IBOutlet weak var timelineTableView: UITableView!
    private let searchController: UISearchController = UISearchController(searchResultsController: nil)
    
    var viewModel: TimelineViewViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "타임라인"
        
        searchController.searchBar.placeholder = "검색어로 일기를 찾아보세요.."
        searchController.searchBar.tintColor = .black
        searchController.searchBar.autocapitalizationType = .none
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        
        navigationItem.searchController = searchController
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        timelineTableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if searchController.isActive {
            viewModel.searchText = nil
            searchController.isActive = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "addEntry":
            let entryVC = segue.destination as? EntryViewController
            entryVC?.viewModel = viewModel.newEntryViewViewModel
            
        case "showEntry":
            if
                let entryVC = segue.destination as? EntryViewController,
                let selectedIndexPath = timelineTableView.indexPathForSelectedRow {
                entryVC.viewModel = viewModel.entryViewViewModel(for: selectedIndexPath)
            }
        
        case "showSettings":
            if
                let settingsVC = segue.destination as? SettingsTableViewController {
                settingsVC.viewModel = viewModel.settingsViewModel
            }
            
        default:
            break
        }
    }

}

extension TimelineTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfDates
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.headerTitle(of: section)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineCell", for: indexPath) as? TimelineTableViewCell else { fatalError("TimelineCell Invalid") }
        
        cell.viewModel = viewModel.timelineTableViewCellViewModel(for: indexPath)
        return cell
    }
}

extension TimelineTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        guard searchController.isActive == false else {
            return UISwipeActionsConfiguration(actions: [])
        }
        
        let removeAction = UIContextualAction(style: .normal, title:  nil) { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            
            let isLastEntryInSection = self.viewModel.numberOfRows(in: indexPath.section) == 1
            self.viewModel.removeEntry(at: indexPath)
            
            UIView.animate(withDuration: 0.3) {
                tableView.beginUpdates()
                if isLastEntryInSection {
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

extension TimelineTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        
        viewModel.searchText = searchText
        timelineTableView.reloadData()
    }
}
