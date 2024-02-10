//
//  Friends+CoreDataProperties.swift
//  Homework6
//
//  Created by Максим Бобков on 06.02.2024.
//
//

import Foundation
import CoreData


extension Friends {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friends> {
        return NSFetchRequest<Friends>(entityName: "Friends")
    }

    @NSManaged public var id: Int64
    @NSManaged public var firstName: String?
    @NSManaged public var lastName: String?
    @NSManaged public var online: Int64
    @NSManaged public var photo: String?

}

extension Friends : Identifiable {

}
