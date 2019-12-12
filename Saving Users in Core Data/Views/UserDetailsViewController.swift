//
//  UserDetailsViewController.swift
//  Saving Users in Core Data
//
//  Created by Rinalds Domanovs on 12/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import UIKit

class UserDetailsViewController: UIViewController {

    var user: User!

    var vStack: UIStackView!


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationController?.navigationBar.prefersLargeTitles = false
        title = "User Details"

        loadData()
    }

    func loadData() {
        vStack = UIStackView()
        vStack.axis = .vertical
        vStack.alignment = .center
        vStack.distribution = .fillEqually
        vStack.spacing = 8
        vStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(vStack)

        NSLayoutConstraint.activate([
            vStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            vStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            vStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])

        if let firstName = user.firstName, let lastName = user.lastName {
            let nameLabel = UILabel()
            nameLabel.text = "\(firstName) \(lastName)"
            vStack.addArrangedSubview(nameLabel)
        }

        if let address = user.address,
            let street = address.street,
            let city = address.city,
            let country = address.country,
            let zip = address.zip {
                let addressLabel = UILabel()
                addressLabel.text = "\(street), \(city), \(country), \(zip)"
                vStack.addArrangedSubview(addressLabel)
        }

    }

}
