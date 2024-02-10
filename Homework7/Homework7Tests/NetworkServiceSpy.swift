//
//  NetworkServiceMock.swift
//  Homework7Tests
//
//  Created by Максим Бобков on 10.02.2024.
//

@testable import Homework7

final class NetworkServiceSpy: NetworkServiceProtocol {
    
    private(set) var isGetFriendsWasCalled = false
    private(set) var isGetGroupssWasCalled = false
    private(set) var isGetPhotosWasCalled = false
    private(set) var isGetProfileInfoWasCalled = false
    
    func getFriends(completion: @escaping (Result<[Homework7.Friend], Error>) -> Void) {
        isGetFriendsWasCalled = true
    }
    
    func getGroups(completion: @escaping (Result<[Homework7.Group], Error>) -> Void) {
        isGetGroupssWasCalled = true
    }
    
    func getPhotos(completion: @escaping ([Homework7.Photo]) -> Void) {
        isGetPhotosWasCalled = true
    }
    
    func getProfileInfo(completion: @escaping (Homework7.Profile) -> Void) {
        isGetProfileInfoWasCalled = true
    }
}
