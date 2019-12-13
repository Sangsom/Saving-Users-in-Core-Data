//
//  AddUserViewController.swift
//  Saving Users in Core Data
//
//  Created by Rinalds Domanovs on 12/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import UIKit

class AddUserViewController: UIViewController {

    var usersController = UserController()

    var vStack: UIStackView!

    var nameTextField: FormTextField!
    var surnameTextField: FormTextField!

    var streetTextField: FormTextField!
    var countryTextField: FormTextField!
    var cityTextField: FormTextField!
    var zipTextField: FormTextField!

    var saveButton: UIButton!

    var isValid = false {
        didSet {
            saveButton.isEnabled = isValid
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

    func setupUI() {
        vStack = UIStackView()
        vStack.axis = .vertical
        vStack.alignment = .fill
        vStack.distribution = .fillEqually
        vStack.spacing = 8
        vStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vStack)

        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)

        ])

        let nameLabel = UILabel()
        nameLabel.text = "Name"
        vStack.addArrangedSubview(nameLabel)

        nameTextField = FormTextField()
        nameTextField.delegate = self
        nameTextField.placeholder = "Name"
        vStack.addArrangedSubview(nameTextField)

        surnameTextField = FormTextField()
        surnameTextField.delegate = self
        surnameTextField.placeholder = "Surname"
        vStack.addArrangedSubview(surnameTextField)

        let addressLabel = UILabel()
        addressLabel.text = "Address Details"
        vStack.addArrangedSubview(addressLabel)

        streetTextField = FormTextField()
        streetTextField.placeholder = "Street"
        vStack.addArrangedSubview(streetTextField)

        countryTextField = FormTextField()
        countryTextField.placeholder = "Country"
        vStack.addArrangedSubview(countryTextField)

        cityTextField = FormTextField()
        cityTextField.placeholder = "City"
        vStack.addArrangedSubview(cityTextField)

        zipTextField = FormTextField()
        zipTextField.placeholder = "Zip/Postal Code"
        vStack.addArrangedSubview(zipTextField)

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

        let user = User(context: PersistanceService.context)
        user.firstName = firstName
        user.lastName = lastName

        let street = streetTextField.text ?? ""
        let country = countryTextField.text ?? ""
        let city = cityTextField.text ?? ""
        let zip = zipTextField.text ?? ""

        let address = Address(context: PersistanceService.context)
        address.street = street
        address.country = country
        address.city = city
        address.zip = zip

        user.address = address

        usersController.addUser(user: user)

        for textField in vStack.arrangedSubviews where textField is UITextField {
            let field = textField as! UITextField
            field.text = ""
            field.resignFirstResponder()
        }

        self.dismiss(animated: true) {
            print("Dismissing")
        }
    }

}

extension AddUserViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let firstName = nameTextField.text, let lastName = surnameTextField.text {
            if !firstName.isEmpty && !lastName.isEmpty {
                isValid = true
            }
        }
    }
}

