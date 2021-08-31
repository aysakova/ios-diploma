//
//  ProgressCollectionViewCell.swift
//  MyHabits
//
//  Created by Aysa Minkova on 2021/08/30.
//

import UIKit

class ProgressCollectionViewCell: UICollectionViewCell {
    
//    private var progressInfo: Habit {
//        didSet {
//            percentOfCOmpletionLabel.text = Habit.t
//        }
//    }
    
    private var cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var progressMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "Все получится!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var percentOfCOmpletionLabel: UILabel = {
        let label = UILabel()
        label.text = "50%"
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = .gray
        progressView.progressTintColor = .orange
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.setProgress(0.7, animated: false)
        return progressView
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

extension ProgressCollectionViewCell {
    private func setupView() {
        
        contentView.addSubview(cellBackgroundView)
        contentView.addSubview(progressMessageLabel)
        contentView.addSubview(percentOfCOmpletionLabel)
        contentView.addSubview(progressView)
        
        contentView.clipsToBounds = true
        
        cellBackgroundView.layer.cornerRadius = 8
        cellBackgroundView.clipsToBounds = true
        
        let constraints = [
            
            cellBackgroundView.leadingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            cellBackgroundView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 22),
            cellBackgroundView.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            cellBackgroundView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor),
            
            progressMessageLabel.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 12),
            progressMessageLabel.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 10),
            progressMessageLabel.widthAnchor.constraint(equalTo: cellBackgroundView.widthAnchor, multiplier: 0.67, constant: -12),
            progressMessageLabel.heightAnchor.constraint(equalToConstant: 18),
            
            percentOfCOmpletionLabel.leadingAnchor.constraint(equalTo: progressMessageLabel.trailingAnchor, constant: 8),
            percentOfCOmpletionLabel.topAnchor.constraint(equalTo: cellBackgroundView.topAnchor, constant: 10),
            percentOfCOmpletionLabel.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -12),
            percentOfCOmpletionLabel.heightAnchor.constraint(equalToConstant: 18),
            
            
            progressView.leadingAnchor.constraint(equalTo: cellBackgroundView.leadingAnchor, constant: 12),
//            progressView.topAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor, constant: 10),
            progressView.trailingAnchor.constraint(equalTo: cellBackgroundView.trailingAnchor, constant: -12),
            progressView.bottomAnchor.constraint(equalTo: cellBackgroundView.bottomAnchor, constant: -15),
            progressView.heightAnchor.constraint(equalToConstant: 7),
            
            ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
