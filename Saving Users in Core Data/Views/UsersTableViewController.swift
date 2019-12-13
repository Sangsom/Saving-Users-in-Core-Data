//
//  UsersTableViewController.swift
//  Saving Users in Core Data
//
//  Created by Rinalds Domanovs on 12/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import UIKit
import CoreData

class UsersTableViewController: UITableViewController {

    var usersController = UserController()
    var users = [User]()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.topItem?.title = "Users"

        loadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addUser))
    }

    func loadData() {
        users = usersController.loadUsers()
        tableView.reloadData()
    }

    @objc func addUser() {
        performSegue(withIdentifier: "AddUser", sender: self)
    }
}

// MARK: - Table view data source
extension UsersTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let fullName = "\(users[indexPath.row].firstName!) \(users[indexPath.row].lastName!)"
        cell.textLabel?.text = fullName
        cell.detailTextLabel?.text = users[indexPath.row].address?.country
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(identifier: "UserDetails") as? UserDetailsViewController {
            vc.user = users[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
