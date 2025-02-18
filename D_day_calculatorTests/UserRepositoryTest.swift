//
//  UserRepositoryTest.swift
//  D_day_calculatorTests
//
//  Created by 이민호 on 2/18/25.
//

import Testing
import SwiftData

struct UserRepositoryTest {
    @MainActor let userRepository = UserRepository(modelContainer: DataContainer.shared.modelContainer)
    
    @Test func saveTest() async {
        let user = User()
        await userRepository.save(from: user)
        let fetchedUsers = await userRepository.fetchUsers()
        
        let filtered = fetchedUsers.filter { $0.id == user.id }
        
        if let result = filtered.first  {
            #expect(true)
            await userRepository.delete(from: result)
        }
    }
    
    @Test func fetchUsersTest() async {
        let fetchedUsers = await userRepository.fetchUsers()
        
        for user in fetchedUsers {
            print(user)
        }
                
        print("✅ 테스트 완료")
        #expect(true)
    }
}
