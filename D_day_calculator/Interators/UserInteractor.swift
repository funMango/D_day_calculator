//
//  UserInteractor.swift
//  D_day_calculator
//
//  Created by 이민호 on 2/16/25.
//

import Foundation

protocol UserProtocol {
    func save(from user: User) async
    func updateUser(from user: User) async
    func fetchUser() async -> User?
}

class UserInteractor: UserProtocol {
    private let userRepository: UserRepoProtocol
    
    init(userRepository: UserRepoProtocol) {
        self.userRepository = userRepository
    }
    
    func save(from user: User) async {
        await userRepository.save(from: user)
    }
    
    func updateUser(from user: User) async {
        await userRepository.updateUser(from: user)
    }
    
    func fetchUser() async -> User? {
        await userRepository.fetchUser()
    }
}
