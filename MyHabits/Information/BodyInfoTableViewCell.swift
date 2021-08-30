//
//  BodyInfoTableViewCell.swift
//  MyHabits
//
//  Created by Aysa Minkova on 2021/08/30.
//

import UIKit

class BodyInfoTableViewCell: UITableViewCell {
    
    private lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.text = AppInfo.myInfo.headerText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTableCellView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupTableCellView()
    }
}

extension BodyInfoTableViewCell {
    private func setupTableCellView() {
        contentView.addSubview(bodyLabel)
        contentView.clipsToBounds = true
        
        let constraints = [
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bodyLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
