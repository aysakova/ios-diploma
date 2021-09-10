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
    
    var selectedIndexPath: IndexPath?

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
        collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
}

extension HabitsViewController {
    private func setupNavigation() {
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
        return store.habits.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: HabitCollectionViewCell.self), for: indexPath) as! HabitCollectionViewCell
            cell.habitNameLabel.text = store.habits[indexPath.row].name
            cell.checkmarkButton.tintColor = UIColor(cgColor: store.habits[indexPath.row].color.cgColor)
            cell.habitNameLabel.textColor = store.habits[indexPath.row].color
            cell.frequencyTimeLabel.text = store.habits[indexPath.row].dateString
            cell.delegate = self
        
        if cell.habitNameLabel.text == store.habits[indexPath.row].name, store.habits[indexPath.row].isAlreadyTakenToday {

//        if store.habit(store.habits[indexPath.row], isTrackedIn: store.dates.last!) {
//            print(store.dates.last!)
//            print(store.habits[indexPath.row].trackDates)
            let configuration = UIImage.SymbolConfiguration(pointSize: 38, weight: .light)
            cell.checkmarkButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill")?.applyingSymbolConfiguration(configuration), for: .normal)
            cell.counterLabel.text = "Счетчик: \(store.habits[indexPath.row].trackDates.count)"
            cell.checkmarkButton.backgroundColor = .white
        }
            return cell
            

    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: ProgressCollectionViewCell.self), for: indexPath) as! ProgressCollectionViewCell
        sectionHeader.percentOfCompletionLabel.text = "\(Int(store.todayProgress * 100))%"
        sectionHeader.progressView.setProgress(store.todayProgress, animated: true)
        return sectionHeader
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    
}

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.width * 0.4)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
            //MARK: Transition to Details View Controller
        let vc = HabitDetailsViewController()
        vc.title = store.habits[indexPath.row].name
        vc.selectedIndexPath = indexPath
        vc.deleteDelegate = self
        self.navigationController?.pushViewController(vc, animated: true)
        
        selectedIndexPath = indexPath
        vc.selectedIndexPath = selectedIndexPath
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
            if !store.habits[indexPath.row].isAlreadyTakenToday {
                store.track(store.habits[indexPath.row])
                collectionView.reloadData()
                cell.counterLabel.text = "Счетчик: \(store.habits[indexPath.row].trackDates.count)"
                let configuration = UIImage.SymbolConfiguration(pointSize: 38, weight: .light)
                cell.checkmarkButton.setBackgroundImage(UIImage(systemName: "checkmark.circle.fill")?.applyingSymbolConfiguration(configuration), for: .normal)
                cell.checkmarkButton.backgroundColor = .white
            } 
    }
}
}

extension HabitsViewController: DeleteHabitDelegate {
    func deleteHabit(atIndex: IndexPath) {
        store.habits.remove(at: atIndex.row)
        collectionView.deleteItems(at: [atIndex])
        
    }
    
    
    
  }
