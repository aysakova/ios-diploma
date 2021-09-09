//
//  HeaderInfoTableCell.swift
//  MyHabits
//
//  Created by Aysa Minkova on 2021/08/30.
//

import UIKit

class HeaderInfoTableViewCell: UITableViewCell {

    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont(name: "SFProDisplay-Semibold", size: 17)
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

extension HeaderInfoTableViewCell {
    private func setupTableCellView() {
        contentView.addSubview(headerLabel)
        contentView.clipsToBounds = true
        
        let constraints = [
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 22),
            headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            headerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
