//
//  HabitDetailsViewController.swift
//  MyHabits
//
//  Created by Aysa Minkova on 2021/08/31.
//

import UIKit

class HabitDetailsViewController: UIViewController {
    
    var selectedIndexPath: IndexPath?
    var deleteDelegate: DeleteHabitDelegate?
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Править", style: .plain, target: self, action: #selector(editButtonTapped))
        
//        navigationItem.largeTitleDisplayMode = .never
//        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.tintColor = UIColor(named: "myPurple")
    }
    @objc private func cancelButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func editButtonTapped() {
        let vc = HabitViewController()
        vc.title = "Править"
        vc.habitNameTextField.text = habit.habits[(selectedIndexPath?.row)!].name
        vc.colorPickerButton.backgroundColor = habit.habits[(selectedIndexPath?.row)!].color
        vc.timePickTextField.text = habit.habits[(selectedIndexPath?.row)!].dateString
        vc.selectedIndex = selectedIndexPath
        vc.deleteDelegate = HabitsViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
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
        return habit.dates.count
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard habit.dates.count != 0 else { return UITableViewCell()}
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
            
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
            cell.textLabel?.text = dateFormatter.string(from: habit.dates[indexPath.row])
        
        if habit.habit(habit.habits[selectedIndexPath!.row], isTrackedIn: habit.dates[indexPath.row])  {
        cell.accessoryType = .checkmark
            cell.tintColor = UIColor(named: "myPurple")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard section != 0 else {return "АКТИВНОСТЬ"}
        return nil
    }
}

extension HabitDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
}

