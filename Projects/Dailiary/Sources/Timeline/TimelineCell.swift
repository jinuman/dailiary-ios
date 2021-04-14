//
//  TimelineCell.swift
//  Dailiary
//
//  Created by Jinwoo Kim on 28/03/2019.
//  Copyright © 2019 jinuman. All rights reserved.
//

import UIKit

class TimelineCell: UITableViewCell {
    
    // MARK:- Properties
    var viewModel: TimelineCellViewModel? {
        didSet {
            fillupCell(with: viewModel)
        }
    }
    
    // MARK:- Screen properties
    private let diaryTextLabel: UILabel = {
        let label = UILabel()
        label.text = "일기 내용"
        label.numberOfLines = 3
        return label
    }()
    
    private let ampmLabel: UILabel = {
        let label = UILabel()
        label.text = "PM"
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let clockLabel: UILabel = {
        let label = UILabel()
        label.text = "11:30"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .lightGray
        return label
    }()
    
    // MARK:- Initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- Setup screen properties
    private func setupCell() {
        let timeStackView = UIStackView(arrangedSubviews: [ampmLabel, clockLabel])
        timeStackView.axis = .vertical
        timeStackView.distribution = .fill
        timeStackView.alignment = .center
        timeStackView.spacing = 2
        
        let stackView = UIStackView(arrangedSubviews: [diaryTextLabel, timeStackView])
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
        
        addSubview(stackView)
        
        timeStackView.constrainWidth(constant: 80)
        
        stackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor,
                         padding: UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12))
        
    }
    
    // MARK:- Handling methods
    // 뷰는 모델에 대해서 알 수 없고, 대신 뷰모델과 커뮤니케이션을 한다.
    private func fillupCell(with viewModel: TimelineCellViewModel?) {
        guard let viewModel = viewModel else { return }
        
        diaryTextLabel.text = viewModel.diaryText
        diaryTextLabel.font = viewModel.diaryTextFont
        ampmLabel.text = viewModel.ampm
        clockLabel.text = viewModel.clock
    }
}
