//
//  ViewController.swift
//  MyHabits
//
//  Created by Aysa Minkova on 2021/08/30.
//

import Foundation
import UIKit



class HabitsViewController: UIViewController {
    
    private var habitArray = HabitsStore.shared
    
    var selectedIndexPath: IndexPath? // index to pass to details and habit view controllers
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray6
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: HabitCollectionViewCell.self))
        collectionView.register(ProgressCollectionViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: ProgressCollectionViewCell.self))
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigation()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        collectionView.reloadData()
    }
    
}

extension HabitsViewController {
    private func setupNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
    }
    
    @objc private func didTapAddButton() {
        let vc = HabitViewController()
        vc.addDelegate = self
        let navVC = UINavigationController(rootViewController: vc)
        vc.title = "Создать"
        self.navigationController?.present(navVC, animated: true, completion: nil)
    }
}

extension HabitsViewController {
    private func setupView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
        ]
        NSLayoutConstraint.activate(constraints)
        
    }
}

extension HabitsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habitArray.habits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as! HabitCollectionViewCell
        
        
        cell.habitNameLabel.text = habitArray.habits[indexPath.row].name
        cell.checkmarkButton.tintColor = UIColor(cgColor: habitArray.habits[indexPath.row].color.cgColor)
        cell.habitNameLabel.textColor = habitArray.habits[indexPath.row].color
        cell.frequencyTimeLabel.text = habitArray.habits[indexPath.row].dateString
        cell.checkmarkButton.isSelected = habitArray.habits[indexPath.row].isAlreadyTakenToday
        cell.counterLabel.text = "Счетчик: \(habitArray.habits[indexPath.row].trackDates.count.description)"
        cell.checkmarkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as! ProgressCollectionViewCell
        sectionHeader.percentOfCompletionLabel.text = "\(Int(habitArray.todayProgress * 100))%"
        sectionHeader.progressView.setProgress(habitArray.todayProgress, animated: true)
        return sectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 80)
    }
    
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //MARK: Transition to Details View Controller
        let vc = HabitDetailsViewController()
        vc.title = habitArray.habits[indexPath.row].name
        vc.selectedIndexPath = indexPath
        vc.deleteDelegate = self
        navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.pushViewController(vc, animated: true)
        
        selectedIndexPath = indexPath
        vc.selectedIndexPath = selectedIndexPath
        
    }
}

extension HabitsViewController: AddHabitDelegate {
    func addHabit(habit: Habit) {
        //        self.dismiss(animated: true, completion: nil)
        habitArray.habits.append(habit)
        self.collectionView.reloadData()
    }
}

extension HabitsViewController: DeleteHabitDelegate {
    func deleteHabit(atIndex: IndexPath) {
        habitArray.habits.remove(at: atIndex.row)
        collectionView.reloadData()
    }
}

extension HabitsViewController {
    @objc func checkButtonClicked(sender: UIButton) {
        if sender.isSelected == false {
            sender.isSelected = true
            sender.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .selected)
            // MARK: Getting indexPath.row of button's superview cell
            var superview = sender.superview
            while let view = superview, !(view is UICollectionViewCell) {
                superview = view.superview
            }
            guard let cell = superview as? UICollectionViewCell else {
                return
            }
            guard let indexPath = collectionView.indexPath(for: cell) else {
                return
            }
            
            if !habitArray.habits[indexPath.row].isAlreadyTakenToday {
                habitArray.track(habitArray.habits[indexPath.row])
            }
        }
        collectionView.reloadData()
    }
    
}
