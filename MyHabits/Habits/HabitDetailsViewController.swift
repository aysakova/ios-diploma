//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Aysa Minkova on 2021/08/31.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    private var habit = HabitsStore.shared
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.dataSource = self
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        setupView()
        setupNavigation()
        
        tableView.tableFooterView = UIView()
    }
    
    
    private func setupNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .done, target: self, action: #selector(editButtonTapped))
        
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .purple
    }
    @objc private func cancelButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func editButtonTapped() {
        let vc = HabitViewController()
        let navVC = UINavigationController(rootViewController: vc)
        vc.title = "Править"
        vc.habitNameTextField.text = self.title
        
        self.navigationController?.present(navVC, animated: true, completion: nil)
    }

}

extension HabitDetailsViewController {
    private func setupView() {
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

extension HabitDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 4
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section != 0 else {return "АКТИВНОСТЬ"}
        return nil
    }
}

extension HabitDetailsViewController: UITableViewDelegate {

}


//

