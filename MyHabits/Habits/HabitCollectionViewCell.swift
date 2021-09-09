//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Aysa Minkova on 2021/08/30.
//

import UIKit

protocol TapButtonDelegate {
    func didTapButton(cell: HabitCollectionViewCell)
}

class HabitCollectionViewCell: UICollectionViewCell {
    
    var delegate: TapButtonDelegate?
    
    private lazy var cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var habitNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProText-Semibold", size: 17)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var frequencyTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = .systemGray2
        return label
    }()
    
    lazy var counterLabel: UILabel = {
        let label = UILabel()
        label.text = "Счетчик: 0"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "SFProText-Regular", size: 13)
        label.textColor = .systemGray2
        return label
    }()
    
    lazy var checkmarkButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 38, weight: .thin)
        button.setBackgroundImage(UIImage(systemName: "circle")?.applyingSymbolConfiguration(configuration), for: .normal)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()
    
    @objc func didTapButton(_ sender: UIButton) {
        delegate?.didTapButton(cell: self)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
}

extension HabitCollectionViewCell {
    private func setupView() {
        contentView.addSubview(cellBackgroundView)
        contentView.addSubview(habitNameLabel)
        contentView.addSubview(frequencyTimeLabel)
        contentView.addSubview(counterLabel)
        contentView.addSubview(checkmarkButton)
        
        cellBackgroundView.layer.cornerRadius = 8
        cellBackgroundView.clipsToBounds = true
                
        let constraints = [
            cellBackgroundView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            cellBackgroundView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 22),
            cellBackgroundView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            cellBackgroundView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            
            habitNameLabel.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 12),
            habitNameLabel.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 10),
            
            frequencyTimeLabel.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 12),
            frequencyTimeLabel.topAnchor.constraint(equalTo: habitNameLabel.bottomAnchor, constant: 4),
            
            counterLabel.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 12),
            counterLabel.bottomAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor, constant: -20),
            
            checkmarkButton.centerYAnchor.constraint(equalTo: cellBackgroundView.centerYAnchor),
            checkmarkButton.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -25),
            checkmarkButton.heightAnchor.constraint(equalToConstant: 38),
            checkmarkButton.widthAnchor.constraint(equalToConstant: 38),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
