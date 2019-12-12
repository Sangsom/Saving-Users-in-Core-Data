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

    var users = [User]()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.topItem?.title = "Users"

        loadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func loadData() {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()

        do {
            let users = try PersistanceService.context.fetch(fetchRequest)
            self.users = users
            self.tableView.reloadData()
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension UsersTableViewController {
    // MARK: - Table view data source
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
            navigationController?.pushViewController(vc, animated: true)
        }
    }

}
