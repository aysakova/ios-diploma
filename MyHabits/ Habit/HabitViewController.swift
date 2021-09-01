//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Aysa Minkova on 2021/08/31.
//

import UIKit

class HabitViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "НАЗВАНИЕ"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var habitNameTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        return text
    }()
    
    private var colorLabel: UILabel = {
        let label = UILabel()
        label.text = "ЦВЕТ"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var colorCircleButton: UIButton = {
        let image = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .brown
        image.addTarget(self, action: #selector(chooseColor), for: .touchUpInside)
        return image
    }()
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var inputTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "Выбрать время"
        return text
    }()
    
    private var timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.preferredDatePickerStyle = .wheels
        picker.datePickerMode = .time
        picker.backgroundColor = .white
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.addTarget(self, action: #selector(timeChanged), for: .valueChanged)
        return picker
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Создать" // change to code
        
        view.backgroundColor = .white
        
        setupView()
        configureNavigationBar()
        createTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    
    private func configureNavigationBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(cancelButtonTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(saveButtonTapped))
        navigationItem.largeTitleDisplayMode = .never
    }
    
    private func createTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
    }
   
    
    @objc private func cancelButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveButtonTapped() {
    }
    
    @objc func timeChanged(timePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        inputTextField.text = dateFormatter.string(from: timePicker.date)
    }
    
    @objc private func viewTapped() {
        view.endEditing(true)
    }

    @objc private func chooseColor() {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        self.present(colorPickerVC, animated: true, completion: nil)
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        colorCircleButton.backgroundColor = color
    }
}

extension HabitViewController {
    private func setupView() {
        view.addSubview(nameLabel)
        view.addSubview(habitNameTextField)
        view.addSubview(colorLabel)
        view.addSubview(colorCircleButton)
        view.addSubview(timeLabel)
        view.addSubview(inputTextField)
        view.addSubview(timePicker)
        
        colorCircleButton.layer.cornerRadius = 30 / 2
        colorCircleButton.clipsToBounds = true
        
        let constraints = [
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            
            habitNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            habitNameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            
            colorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            colorLabel.topAnchor.constraint(equalTo: habitNameTextField.bottomAnchor, constant: 15),
            
            colorCircleButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            colorCircleButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorCircleButton.widthAnchor.constraint(equalToConstant: 30),
            colorCircleButton.heightAnchor.constraint(equalToConstant: 30),
            
            timeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            timeLabel.topAnchor.constraint(equalTo: colorCircleButton.bottomAnchor, constant: 15),
            
            inputTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            inputTextField.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 15),
            inputTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            inputTextField.heightAnchor.constraint(equalToConstant: 50),
            
            timePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            timePicker.topAnchor.constraint(equalTo: inputTextField.bottomAnchor),
            timePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            timePicker.heightAnchor.constraint(equalToConstant: 250),
    
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}

