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
    
    var viewModel: TimelineViewViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "타임라인"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.dates = viewModel.environment.entryRepository.uniqueDates
        timelineTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "addEntry":
            let entryVC = segue.destination as? EntryViewController
            entryVC?.environment = viewModel.environment
            entryVC?.delegate = self
        case "showEntry":
            if
                let entryVC = segue.destination as? EntryViewController,
                let selectedIndexPath = timelineTableView.indexPathForSelectedRow {
                entryVC.editingEntry = viewModel.entry(for: selectedIndexPath)
                entryVC.environment = viewModel.environment
                entryVC.delegate = self
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
        
        let entry = self.viewModel.entry(for: indexPath)
        
        cell.entryTextLabel.text = entry.text
        cell.ampmLabel.text = DateFormatter.ampmFormatter.string(from: entry.createdAt)
        cell.timeLabel.text = DateFormatter.entryTimeFormatter.string(from: entry.createdAt)
        
        return cell
    }
}

extension TimelineTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
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

extension TimelineTableViewController: EntryViewControllerDelegate {
    func didRemoveEntry(_ entry: Entry) {
        navigationController?.popViewController(animated: true)
    }
}
