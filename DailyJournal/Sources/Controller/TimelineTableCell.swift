//
//  TimelineTableCell.swift
//  DailyJournal
//
//  Created by Jinwoo Kim on 2018. 12. 19..
//  Copyright © 2018년 jinuman. All rights reserved.
//

import UIKit

class TimelineTableCell: UITableViewCell {

    @IBOutlet weak var journalTextLabel: UILabel!
    @IBOutlet weak var ampmLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var viewModel: TimelineTableCellViewModel? {
        didSet {
            setupCell(with: viewModel)
        }
    }
    
    private func setupCell(with viewModel: TimelineTableCellViewModel?) {
        journalTextLabel.text = viewModel?.journalText
        journalTextLabel.font = viewModel?.journalTextFont
        ampmLabel.text = viewModel?.ampmText
        timeLabel.text = viewModel?.timeText
    }
}
