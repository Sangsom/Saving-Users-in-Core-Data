//
//  User+CoreDataProperties.swift
//  Saving Users in Core Data
//
//  Created by Rinalds Domanovs on 12/12/2019.
//  Copyright © 2019 Rinalds Domanovs. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var address: Address?

}
