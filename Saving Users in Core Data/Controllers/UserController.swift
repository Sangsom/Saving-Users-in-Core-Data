//
//  UserController.swift
//  Saving Users in Core Data
//
//  Created by Rinalds Domanovs on 13/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import Foundation
import CoreData

class UserController {

    func loadUsers() -> [User] {
        var usersList = [User]()

        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()

        do {
            let users = try PersistanceService.context.fetch(fetchRequest)
            usersList = users
        } catch {
            print(error.localizedDescription)
        }

        return usersList
    }

}
