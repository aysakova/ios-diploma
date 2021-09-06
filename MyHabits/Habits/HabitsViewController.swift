//
//  ViewController.swift
//  MyHabits
//
//  Created by Aysa Minkova on 2021/08/30.
//

import Foundation
import UIKit

class HabitsViewController: UIViewController {
    
    private var store = HabitsStore.shared

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
}

extension HabitsViewController {
    private func setupNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAddButton))
        
    }
    
    @objc private func didTapAddButton() {
        let vc = HabitViewController()
        vc.delegate = self
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
        return store.habits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as! HabitCollectionViewCell
            cell.habitNameLabel.text = store.habits[indexPath.row].name
            cell.checkmarkButton.tintColor = UIColor(cgColor: store.habits[indexPath.row].color.cgColor)
            cell.habitNameLabel.textColor = store.habits[indexPath.row].color
            cell.frequencyTimeLabel.text = store.habits[indexPath.row].dateString
            cell.delegate = self
            cell.checkmarkButton.isUserInteractionEnabled = true
            return cell
//        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as! ProgressCollectionViewCell
        return sectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.width * 0.350)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        6
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        if indexPath.row != 0 {
            let vc = HabitDetailsViewController()
            vc.title = store.habits[indexPath.row].name
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension HabitsViewController: AddHabitDelegate {
    func addHabit(habit: Habit) {
        self.dismiss(animated: true, completion: nil)
        store.habits.append(habit)
        self.collectionView.reloadData()
    }
}

extension HabitsViewController: TapButtonDelegate {
    func didTapButton(cell: HabitCollectionViewCell) {
        if let indexPath = collectionView.indexPath(for: cell) {
            print(indexPath)
            cell.checkmarkButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
            cell.checkmarkButton.backgroundColor = .white
            let habit = store.habits[indexPath.row]
            if !habit.isAlreadyTakenToday  {
                store.track(habit)
            }
            cell.counterLabel.text = "Счетчик: \(store.dates.count)"
            print(store.dates)
            
        }
    }
    
    
    
    
}
