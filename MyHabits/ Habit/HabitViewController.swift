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

class HabitViewController: UIViewController, UIColorPickerViewControllerDelegate {
    
    var selectedRow: Int = 0
    var selectedIndex: IndexPath?
    
    var habitArray = HabitsStore.shared
    
    private var store = HabitsStore.shared
    var addDelegate: AddHabitDelegate?
    var deleteDelegate: DeleteHabitDelegate?

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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
    }
    
    
    
    //MARK: Functions
    private func setupNavigation() {
        navigationItem.largeTitleDisplayMode = .never
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Отменить", style: .plain, target: self, action: #selector(didTapCancelButton))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить", style: .done, target: self, action: #selector(didTapSaveButton))
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
        } else {
            
            let habit = Habit(name: habitNameTextField.text!,
                              date: timePicker.date, color: colorPickerButton.backgroundColor!)
            
            habit.trackDates = habitArray.habits[selectedIndex!.row].trackDates
            habitArray.habits.insert(habit, at: selectedIndex!.row)
            habitArray.habits.remove(at: selectedIndex!.row + 1)
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    @objc private func timeChanged(timePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm"
        
        let text = "Каждый день в \(dateFormatter.string(from: timePicker.date))"
        let range = (text as NSString).range(of: "Каждый день в ")
        let attrbutedString = NSMutableAttributedString(string: text)
        attrbutedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.black, range: range)
        timePickTextField.textColor = UIColor(named: "myPurple")
        timePickTextField.attributedText = attrbutedString
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
        
        let alertController = UIAlertController(title: "Удалить привычку", message: "Вы хотите удалить привычку \(habitArray.habits[selectedIndex!.row].name)?", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in
            alertController.dismiss(animated: true, completion: nil)
        }
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            self.deleteDelegate?.deleteHabit(atIndex: self.selectedIndex!)
            self.navigationController?.popToRootViewController(animated: true)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)
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
            timePickTextField.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 7),
            timePickTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            timePicker.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            timePicker.topAnchor.constraint(equalTo: timePickTextField.bottomAnchor),
            timePicker.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            timePicker.heightAnchor.constraint(equalToConstant: 250),
        ]
        NSLayoutConstraint.activate(constraints)
        
//        if !self.habitNameTextField.text!.isEmpty {
            if selectedIndex != nil {
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
