//
//  HabitCollectionViewCell.swift
//  MyHabits
//
//  Created by Aysa Minkova on 2021/08/30.
//

import UIKit

class HabitCollectionViewCell: UICollectionViewCell {
    
    private var cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var habitNameLabel: UILabel = {
        let label = UILabel()
//        label.text = "Некоторая привычка"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    var frequencyTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Каждый день в 00:00"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var counterLabel: UILabel = {
        let label = UILabel()
        label.text = "Счетчик: 0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var checkmarkImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "circle"))
        image.layer.borderWidth = 2
        image.layer.borderColor = UIColor.black.cgColor
        image.clipsToBounds = true
//        image.frame.size = CGSize(width: 38, height: 38)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
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
        contentView.addSubview(checkmarkImage)
        
        cellBackgroundView.layer.cornerRadius = 8
        cellBackgroundView.clipsToBounds = true
        
        checkmarkImage.layer.cornerRadius = 38/2
        checkmarkImage.clipsToBounds = true
        
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
            
            checkmarkImage.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 46),
            checkmarkImage.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -25),
            checkmarkImage.heightAnchor.constraint(equalToConstant: 38),
            checkmarkImage.widthAnchor.constraint(equalToConstant: 38),
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
