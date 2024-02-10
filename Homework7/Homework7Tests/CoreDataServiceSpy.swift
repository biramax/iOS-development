//
//  CoreDataServiceSpy.swift
//  Homework7Tests
//
//  Created by Максим Бобков on 10.02.2024.
//

@testable import Homework7

final class CoreDataServiceSpy: CoreDataServiceProtocol {
    
    private(set) var isSaveFriendsWasCalled = false
    private(set) var isGetFriendsWasCalled = false
    private(set) var isSaveGroupsWasCalled = false
    private(set) var isGetGroupsWasCalled = false
    
    func saveFriends(friends: [Homework7.Friend]) {
        isSaveFriendsWasCalled = true
    }
    
    func getFriends() -> [Homework7.Friend] {
        isGetFriendsWasCalled = true
        return []
    }
    
    func saveGroups(groups: [Homework7.Group]) {
        isSaveGroupsWasCalled = true
    }
    
    func getGroups() -> [Homework7.Group] {
        isGetGroupsWasCalled = true
        return []
    }
}
