//
//  ViewController.swift
//  Saving Users in Core Data
//
//  Created by Rinalds Domanovs on 11/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var nameTextField: FormTextField!
    var surnameTextField: FormTextField!
    var saveButton: UIButton!

    var isValid = false {
        didSet {
            saveButton.isEnabled = isValid
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.topItem?.title = "Add User"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {

        let vStack = UIStackView()
        vStack.axis = .vertical
        vStack.alignment = .fill
        vStack.distribution = .fillEqually
        vStack.spacing = 8
        vStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vStack)

        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8)

        ])

        let nameLabel = UILabel()
        nameLabel.text = "Name"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        vStack.addArrangedSubview(nameLabel)

        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: vStack.leadingAnchor, constant: 8)
        ])

        nameTextField = FormTextField()
        nameTextField.delegate = self
        nameTextField.placeholder = "Name"
        nameTextField.translatesAutoresizingMaskIntoConstraints = false
        vStack.addArrangedSubview(nameTextField)

        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: vStack.leadingAnchor, constant: 8),
            nameTextField.trailingAnchor.constraint(equalTo: vStack.trailingAnchor, constant: 8)
        ])

        surnameTextField = FormTextField()
        surnameTextField.delegate = self
        surnameTextField.placeholder = "Surname"
        surnameTextField.translatesAutoresizingMaskIntoConstraints = false
        vStack.addArrangedSubview(surnameTextField)

        NSLayoutConstraint.activate([
            surnameTextField.leadingAnchor.constraint(equalTo: vStack.leadingAnchor, constant: 8),
            surnameTextField.trailingAnchor.constraint(equalTo: vStack.trailingAnchor, constant: 8)
        ])

        saveButton = UIButton(type: .system)
        saveButton.isEnabled = false
        saveButton.setTitle("Save User", for: .normal)
        saveButton.backgroundColor = .systemBlue
        saveButton.tintColor = .white
        saveButton.layer.cornerRadius = 8
        saveButton.addTarget(self, action: #selector(addUser), for: .touchUpInside)
        vStack.addArrangedSubview(saveButton)
    }

    @objc func addUser(_ sender: UIButton) {
        print("Adding user...")
        guard let firstName = nameTextField.text, let lastName = surnameTextField.text else { return }

        // Create User data
        let address = Address(context: PersistanceService.context)
        address.country = "Latvia"

        let user = User(context: PersistanceService.context)
        user.firstName = firstName
        user.lastName = lastName
        user.address = address

        // Save into Core Data
        PersistanceService.saveContext()

        nameTextField.resignFirstResponder()
        surnameTextField.resignFirstResponder()
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let firstName = nameTextField.text, let lastName = surnameTextField.text {
            if !firstName.isEmpty && !lastName.isEmpty {
                isValid = true
            }
        }
    }
}
