//
//  UserController.swift
//  Saving Users in Core Data
//
//  Created by Rinalds Domanovs on 13/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//

import Foundation
import CoreData
import Contacts

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

    func addUser(user: User) {
        // Save into Core Data
        PersistanceService.saveContext()

        if let firstName = user.firstName,
            let lastName = user.lastName {

            // Create Contact
            let contact = CNMutableContact()

            contact.givenName = firstName
            contact.familyName = lastName

            let homeAddress = CNMutablePostalAddress()
            homeAddress.street = user.address?.street ?? ""
            homeAddress.city = user.address?.city ?? ""
            homeAddress.country = user.address?.country ?? ""
            homeAddress.postalCode = user.address?.zip ?? ""
            contact.postalAddresses = [CNLabeledValue(label: CNLabelHome, value: homeAddress)]

            // Save Contact
            let store = CNContactStore()
            let saveRequest = CNSaveRequest()
            saveRequest.add(contact, toContainerWithIdentifier: nil)
            try! store.execute(saveRequest)
        }
    }

}
