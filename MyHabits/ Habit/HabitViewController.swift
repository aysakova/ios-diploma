//
//  HabitViewController.swift
//  MyHabits
//
//  Created by Aysa Minkova on 2021/08/31.
//

import UIKit

protocol AddHabitDelegate {
    func addHabit(habit: Habit)
}

protocol DeleteHabitDelegate {
    func deleteHabit(atIndex: IndexPath)
}

protocol EditHabitDelegate {
    func editHabit(name: String, dateString: Date, color: UIColor, at index: IndexPath)
}

class HabitViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    var selectedRow: Int = 0
    var selectedIndex: IndexPath?
    
    private var store = HabitsStore.shared
    var addDelegate: AddHabitDelegate?
    var deleteDelegate: DeleteHabitDelegate?
    var editDelegate: EditHabitDelegate?

    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "НАЗВАНИЕ"
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var habitNameTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.placeholder = "Бегать по утрам, спать 8 часов и т.п."
        text.font = UIFont(name: "SFProText-Semibold", size: 17)
        text.textColor = UIColor(named: "myBlue")
//
        
        return text
    }()
    
    private var colorLabel: UILabel = {
        let label = UILabel()
        label.text = "ЦВЕТ"
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var colorPickerButton: UIButton = {
        let image = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.backgroundColor = .red
        image.addTarget(self, action: #selector(chooseColor), for: .touchUpInside)
        return image
    }()
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "ВРЕМЯ"
        label.font = UIFont(name: "SFProText-Semibold", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var timePickTextField: UITextField = {
        let text = UITextField()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.text = "Каждый день в"
        text.font = UIFont(name: "SFProText-Regular", size: 17)
        
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
    
    private var deleteHabitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Удалить привычку", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTapDeleteButton), for: .touchUpInside)
        button.isUserInteractionEnabled = true
        return button
    }()
    
    //MARK: Lifestyle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupView()
        setupNavigation()
        createTapGesture()
        
        habitNameTextField.delegate = self
        timePickTextField.delegate = self

    }
    
    
    //MARK: Functions
    private func setupNavigation() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(didTapCancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(didTapSaveButton))
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.tintColor = .purple
    }
    
    private func createTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
    }
   
    
    @objc private func didTapCancelButton() {
        self.navigationController?.popViewController(animated: true)
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapSaveButton() {
        
        // MARK: Check if no fields are empty
        guard habitNameTextField.hasText, timePickTextField.text != "Каждый день в" else {
            return
        }
        if selectedIndex == nil {
            let newHabit = Habit(name: habitNameTextField.text!,
                                 date: timePicker.date, color: colorPickerButton.backgroundColor!)
            addDelegate?.addHabit(habit: newHabit)
            dismiss(animated: true, completion: nil)
        } else if store.habits[selectedIndex!.row].name == habitNameTextField.text!,
                  store.habits[selectedIndex!.row].dateString == timePickTextField.text!,
                  store.habits[selectedIndex!.row].color == colorPickerButton.backgroundColor! {
                    self.navigationController?.popViewController(animated: true)
        } else {
//            let name = habitNameTextField.text!
//            let date = timePicker.date
//            let color = colorPickerButton.backgroundColor!
//            editDelegate?.editHabit(name: name, dateString: date, color: color, at: selectedIndex!)
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc private func timeChanged(timePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        timePickTextField.text = "Каждый день в \(dateFormatter.string(from: timePicker.date))"
        // TODO: покрасить часть строки
    }
    
    @objc private func viewTapped() {
        view.endEditing(true)
    }

    @objc private func chooseColor() {
        let colorPickerVC = UIColorPickerViewController()
        colorPickerVC.delegate = self
        self.present(colorPickerVC, animated: true, completion: nil)
    }
    
    @objc private func didTapDeleteButton() {
        
        deleteDelegate?.deleteHabit(atIndex: selectedIndex!)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        let color = viewController.selectedColor
        colorPickerButton.backgroundColor = color
    }
    
}
    //MARK: Setup views
extension HabitViewController {
    private func setupView() {
        view.addSubview(nameLabel)
        view.addSubview(habitNameTextField)
        view.addSubview(colorLabel)
        view.addSubview(colorPickerButton)
        view.addSubview(timeLabel)
        view.addSubview(timePickTextField)
        view.addSubview(timePicker)
        
        colorPickerButton.layer.cornerRadius = 30 / 2
        colorPickerButton.clipsToBounds = true
        
        let constraints = [
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 21),
            
            habitNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            habitNameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 7),
            
            colorLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            colorLabel.topAnchor.constraint(equalTo: habitNameTextField.bottomAnchor, constant: 15),
            
            colorPickerButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            colorPickerButton.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 7),
            colorPickerButton.widthAnchor.constraint(equalToConstant: 30),
            colorPickerButton.heightAnchor.constraint(equalToConstant: 30),
            
            timeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            timeLabel.topAnchor.constraint(equalTo: colorPickerButton.bottomAnchor, constant: 15),
            
            timePickTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            timePickTextField.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 15),
            timePickTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            timePickTextField.heightAnchor.constraint(equalToConstant: 50),
            
            timePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            timePicker.topAnchor.constraint(equalTo: timePickTextField.bottomAnchor),
            timePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            timePicker.heightAnchor.constraint(equalToConstant: 250),
        ]
        NSLayoutConstraint.activate(constraints)
        
        if !self.habitNameTextField.text!.isEmpty {
            view.addSubview(deleteHabitButton)
            NSLayoutConstraint.activate([deleteHabitButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                                        deleteHabitButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                                        deleteHabitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
                                        deleteHabitButton.heightAnchor.constraint(equalToConstant: 50)])
        }
    }
}

extension HabitViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        habitNameTextField.resignFirstResponder()
        return true
    }
    
}
