//
//  CoreDataService.swift
//  Homework6
//
//  Created by Максим Бобков on 03.02.2024.
//

import Foundation
import CoreData

protocol CoreDataServiceProtocol {
    
    func saveFriends(friends: [Friend])
    func getFriends() -> [Friend]
    
    func saveGroups(groups: [Group])
    func getGroups() -> [Group]
}

final class CoreDataService: CoreDataServiceProtocol {
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer (name: "CoreDataModel")
        persistentContainer.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                print(error)
            }
        })
        return persistentContainer
    }()

    func saveFriends(friends: [Friend]) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Friends")
        
        for friend in friends {
            
            // Ищем среди сохранённых друзей друга с данным id
            fetchRequest.predicate = NSPredicate(format: "id = %@", argumentArray: [friend.id])
            let result = try? persistentContainer.viewContext.fetch(fetchRequest)
            guard result?.first == nil else {
                continue
            }
            
            // Если такого друга нет в CoreData, добавляем
            let friendModel = Friends(context: persistentContainer.viewContext)
            friendModel.id = Int64(friend.id)
            friendModel.firstName = friend.firstName
            friendModel.lastName = friend.lastName
            friendModel.photo = friend.photo
            friendModel.online = Int64(friend.online)
        }
        
        save()
        saveFriendsDate()
    }
    
    func getFriends() -> [Friend] {
        
        let fetchRequest: NSFetchRequest<Friends> = Friends.fetchRequest()
        guard let friends = try? persistentContainer.viewContext.fetch(fetchRequest) else {
            return []
        }
        
        var newFriends: [Friend] = []
        for friend in friends {
            newFriends.append(Friend(
                id: Int(friend.id),
                firstName: friend.firstName ?? "",
                lastName: friend.lastName ?? "",
                photo: friend.photo ?? "",
                online: Int(friend.online)
            ))
        }
        
        return newFriends
    }
    
    func saveGroups(groups: [Group]) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Groups")
        
        for group in groups {
            
            // Ищем среди сохранённых групп группу с данным id
            fetchRequest.predicate = NSPredicate(format: "id = %@", argumentArray: [group.id])
            let result = try? persistentContainer.viewContext.fetch(fetchRequest)
            guard result?.first == nil else {
                continue
            }
            
            // Если такой группы нет в CoreData, добавляем
            let groupModel = Groups(context: persistentContainer.viewContext)
            groupModel.id = Int64(group.id)
            groupModel.name = group.name
            groupModel.descr = group.description
            groupModel.photo = group.photo
        }
        
        save()
        saveGroupsDate()
    }
    
    func getGroups() -> [Group] {
        
        let fetchRequest: NSFetchRequest<Groups> = Groups.fetchRequest()
        guard let groups = try? persistentContainer.viewContext.fetch(fetchRequest) else {
            return []
        }
        
        var newGroups: [Group] = []
        for group in groups {
            newGroups.append(Group(
                id: Int(group.id),
                name: group.name ?? "",
                description: group.descr ?? "",
                photo: group.photo ?? ""
            ))
        }
        
        return newGroups
    }
}



extension CoreDataService {
        
    func save() {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    func delete(object: NSManagedObject) {
        persistentContainer.viewContext.delete(object)
        save()
    }
}


// Сохранение и получение даты последнего изменения данных друзей и групп
extension CoreDataService {
    
    func saveFriendsDate() {
        _ = NSFetchRequest<NSFetchRequestResult>(entityName: "FriendsDate")
        let date = FriendsDate(context: persistentContainer.viewContext)
        date.date = Date()
        save()
    }
    
    func getFriendsDate() -> Date? {
        let fetchRequest: NSFetchRequest<FriendsDate> = FriendsDate.fetchRequest()
        guard let date = try? persistentContainer.viewContext.fetch(fetchRequest) else {
            return nil
        }
        return date.first?.date
    }
    
    func saveGroupsDate() {
        _ = NSFetchRequest<NSFetchRequestResult>(entityName: "GroupsDate")
        let date = GroupsDate(context: persistentContainer.viewContext)
        date.date = Date()
        save()
    }
    
    func getGroupsDate() -> Date? {
        let fetchRequest: NSFetchRequest<GroupsDate> = GroupsDate.fetchRequest()
        guard let date = try? persistentContainer.viewContext.fetch(fetchRequest) else {
            return nil
        }
        return date.first?.date
    }
}
