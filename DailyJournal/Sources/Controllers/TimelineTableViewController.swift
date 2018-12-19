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
    
    let repo = InMemoryEntryRepository.shared
    private var dates = [Date]()
    private var entries: [Entry] {
        return repo.recentEntries(max: repo.numberOfEntries)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "타임라인"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dates = entries.compactMap {
            $0.createdAt.hmsRemoved
        }.unique()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        switch identifier {
        case "addEntry":
            let entryVC = segue.destination as? EntryViewController
        default:
            break
        }
    }
    
    private func entries(for date: Date) -> [Entry] {
        return entries.filter {
            $0.createdAt.hmsRemoved == date
        }
    }
    
    private func entry(for indexPath: IndexPath) -> Entry {
        let date = dates[indexPath.section]
        let entriesOfDate = entries(for: date)
        let entry = entriesOfDate[indexPath.row]
        return entry
    }

}

extension TimelineTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return dates.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let date = dates[section]
        return DateFormatter.entryDateFormatter.string(from: date)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = dates[section]
        return entries(for: date).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineCell", for: indexPath) as? TimelineTableViewCell else { fatalError("TimelineCell Invalid") }
        
        let entry = self.entry(for: indexPath)
        
        cell.entryTextLabel.text = entry.text
        cell.ampmLabel.text = DateFormatter.ampmFormatter.string(from: entry.createdAt)
        cell.timeLabel.text = DateFormatter.entryTimeFormatter.string(from: entry.createdAt)
        
        return cell
    }
    
}

