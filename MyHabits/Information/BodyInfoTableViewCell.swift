//
//  BodyInfoTableViewCell.swift
//  MyHabits
//
//  Created by Aysa Minkova on 2021/08/30.
//

import UIKit

class BodyInfoTableViewCell: UITableViewCell {
    
    lazy var bodyLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProText-Regular", size: 17)
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
            bodyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            bodyLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            bodyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
