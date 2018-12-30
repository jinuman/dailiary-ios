//
//  TimelineTableViewCell.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 12. 19..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit

class TimelineTableViewCell: UITableViewCell {

    @IBOutlet weak var entryTextLabel: UILabel!
    @IBOutlet weak var ampmLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var viewModel: TimelineTableViewCellViewModel? {
        didSet {
            setupCell(with: viewModel)
        }
    }
    
    private func setupCell(with viewModel: TimelineTableViewCellViewModel?) {
        entryTextLabel.text = viewModel?.entryText
        ampmLabel.text = viewModel?.ampmText
        timeLabel.text = viewModel?.timeText
    }
}
