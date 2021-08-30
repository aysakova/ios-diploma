//
//  InfoViewController.swift
//  MyHabits
//
//  Created by Aysa Minkova on 2021/08/30.
//

import Foundation
import UIKit

class InfoViewController: UIViewController {
    
    private let infoTableView = UITableView(frame: .zero, style: .plain)
    
    private enum CellView {
        case Header, Body, unknown
        
        init (cellView: Int) {
            switch cellView {
            case 0: self = .Header
            case 1: self = .Body
            default: self = .unknown
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        infoTableView.dataSource = self
        infoTableView.register(HeaderInfoTableViewCell.self, forCellReuseIdentifier: String(describing: HeaderInfoTableViewCell.self))
        infoTableView.register(BodyInfoTableViewCell.self, forCellReuseIdentifier: String(describing: BodyInfoTableViewCell.self))

        setupTableView()
    }
    
}

extension InfoViewController {
    private func setupTableView() {
        
        view.addSubview(infoTableView)
        infoTableView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            infoTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            infoTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            infoTableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            infoTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension InfoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch CellView(cellView: indexPath.row) {
        case .Header:
            let cell = infoTableView.dequeueReusableCell(withIdentifier: String(describing: HeaderInfoTableViewCell.self), for: indexPath) as! HeaderInfoTableViewCell
            return cell
        case .Body:
            let cell = infoTableView.dequeueReusableCell(withIdentifier: String(describing: BodyInfoTableViewCell.self), for: indexPath) as! BodyInfoTableViewCell
            return cell
        case .unknown:
            return UITableViewCell()
        }
    }
}

//    private let scrollView = UIScrollView()
//    private let containerView = UIView()
//
//    private var headerLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = AppInfo.myInfo.headerText
//        label.font = UIFont(name: "SF Pro Display", size: 16)
//        return label
//    }()
//
//    private var firstLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = AppInfo.myInfo.headerText
//        label.font = UIFont(name: "SF Pro Display", size: 16)
//        return label
//    }()
//
//    private var secondLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = AppInfo.myInfo.headerText
//        label.font = UIFont(name: "SF Pro Display", size: 16)
//        return label
//    }()
//
//    private var thirdlabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = AppInfo.myInfo.headerText
//        label.font = UIFont(name: "SF Pro Display", size: 16)
//        return label
//    }()
//
//    private var fourthLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = AppInfo.myInfo.headerText
//        label.font = UIFont(name: "SF Pro Display", size: 16)
//        return label
//    }()
//
//    private var fifthLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = AppInfo.myInfo.headerText
//        label.font = UIFont(name: "SF Pro Display", size: 16)
//        return label
//    }()
//
//    private var sixthLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = AppInfo.myInfo.headerText
//        label.font = UIFont(name: "SF Pro Display", size: 16)
//        return label
//    }()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupView()
//
//
//    }
//
//}
//
//extension InfoViewController {
//    private func setupView() {
//
//        view.addSubview(scrollView)
//        scrollView.addSubview(containerView)
//        containerView.addSubview(headerLabel)
//
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        containerView.translatesAutoresizingMaskIntoConstraints = false
//
//
//        let constraints = [
//            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
//
//            containerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
//            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            containerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
//            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//
//            headerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
//            headerLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
//            headerLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
//            headerLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -500),
//
//        ]
//
//        NSLayoutConstraint.activate(constraints)
//    }
//}
