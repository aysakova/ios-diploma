//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Aysa Minkova on 2021/08/30.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
    private var habits = HabitsStore.shared
    
    private lazy var cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var progressMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "Все получится!"
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        label.textColor = .systemGray2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var percentOfCompletionLabel: UILabel = {
        let label = UILabel()
//        label.text = "50%"
        label.font = UIFont(name: "SF-Pro-Text-Semibold", size: 13)
        label.textAlignment = .right
        label.textColor = .systemGray2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = .systemGray2
        progressView.progressTintColor = .purple
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        configure()
       
    }
}

extension ProgressCollectionViewCell {
    private func setupView() {
        
        contentView.addSubview(cellBackgroundView)
        contentView.addSubview(progressMessageLabel)
        contentView.addSubview(percentOfCompletionLabel)
        contentView.addSubview(progressView)
        
        contentView.clipsToBounds = true
        
        cellBackgroundView.layer.cornerRadius = 8
        cellBackgroundView.clipsToBounds = true
        
        progressView.layer.cornerRadius = 3.5
        progressView.clipsToBounds = true
        
        let constraints = [
            
            cellBackgroundView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            cellBackgroundView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 22),
            cellBackgroundView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            cellBackgroundView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            
            progressMessageLabel.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 12),
            progressMessageLabel.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 10),
            progressMessageLabel.widthAnchor.constraint(equalTo: cellBackgroundView.widthAnchor, multiplier: 0.67, constant: -12),
            progressMessageLabel.heightAnchor.constraint(equalToConstant: 18),
            
            percentOfCompletionLabel.leadingAnchor.constraint(equalTo: progressMessageLabel.trailingAnchor, constant: 8),
            percentOfCompletionLabel.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 10),
            percentOfCompletionLabel.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -12),
            percentOfCompletionLabel.heightAnchor.constraint(equalToConstant: 18),
            
            
            progressView.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 12),
            progressView.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -12),
            progressView.bottomAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor, constant: -15),
            progressView.heightAnchor.constraint(equalToConstant: 7),
            
            ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func configure() {
        percentOfCompletionLabel.text = "\(Int(habits.todayProgress * 100))%"
        progressView.setProgress(habits.todayProgress, animated: true)
    }
}
