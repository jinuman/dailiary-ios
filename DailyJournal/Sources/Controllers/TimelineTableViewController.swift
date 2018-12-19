//
//  TimelineTableViewController.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 12. 19..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit

class TimelineTableViewController: UIViewController {

    let repo = InMemoryEntryRepository.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "타임라인"
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

}

extension TimelineTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repo.numberOfEntries
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineCell", for: indexPath) as? TimelineTableViewCell else { fatalError("TimelineCell Invalid") }
        
        
        return cell
    }
    
}

