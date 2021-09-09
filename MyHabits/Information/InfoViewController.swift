//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Aysa Minkova on 2021/08/30.
//

import Foundation
import UIKit

class InfoViewController: UIViewController {
    
    private var model = AppInfo.myInfo
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    private enum CellView {
        case Header, Body
        
        init (cellIndexPathRow: Int) {
            switch cellIndexPathRow {
            case 0: self = .Header
            default: self = .Body
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(HeaderInfoTableViewCell.self, forCellReuseIdentifier: String(describing: HeaderInfoTableViewCell.self))
        tableView.register(BodyInfoTableViewCell.self, forCellReuseIdentifier: String(describing: BodyInfoTableViewCell.self))

        setupView()
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
}

extension InfoViewController {
    private func setupView() {
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.separatorStyle = .none
        
        let constraints = [
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension InfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch CellView(cellIndexPathRow: indexPath.row) {
        case .Header:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HeaderInfoTableViewCell.self), for: indexPath) as! HeaderInfoTableViewCell
            cell.headerLabel.text = model[indexPath.row].text
            return cell
        case .Body:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: BodyInfoTableViewCell.self), for: indexPath) as! BodyInfoTableViewCell
            cell.bodyLabel.text = model[indexPath.row].text
            return cell
        }
    }
    

}
