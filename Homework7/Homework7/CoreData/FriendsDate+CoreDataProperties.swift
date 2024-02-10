//
//  FriendsDate+CoreDataProperties.swift
//  Homework6
//
//  Created by Максим Бобков on 06.02.2024.
//
//

import Foundation
import CoreData


extension FriendsDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FriendsDate> {
        return NSFetchRequest<FriendsDate>(entityName: "FriendsDate")
    }

    @NSManaged public var date: Date?

}

extension FriendsDate : Identifiable {

}
