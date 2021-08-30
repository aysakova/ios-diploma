//
//  HeaderInfoTableCell.swift
//  MyHabits
//
//  Created by Aysa Minkova on 2021/08/30.
//

import UIKit

class HeaderInfoTableViewCell: UITableViewCell {

    private lazy var headerLabel: UILabel = {
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

extension HeaderInfoTableViewCell {
    private func setupTableCellView() {
        contentView.addSubview(headerLabel)
        contentView.clipsToBounds = true
        
        let constraints = [
            headerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            headerLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            headerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
