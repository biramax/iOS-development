//
//  GroupsDate+CoreDataProperties.swift
//  Homework6
//
//  Created by Максим Бобков on 06.02.2024.
//
//

import Foundation
import CoreData


extension GroupsDate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroupsDate> {
        return NSFetchRequest<GroupsDate>(entityName: "GroupsDate")
    }

    @NSManaged public var date: Date?

}

extension GroupsDate : Identifiable {

}
