//
//  UserRepository.swift
//  D_day_calculator
//
//  Created by 이민호 on 2/16/25.
//

import Foundation
import SwiftData
import CoreData

protocol UserRepoProtocol {
    func save(from user: User) async
    func updateUser(from user: User) async
    func fetchUser() async -> User?
}

class UserRepository: UserRepoProtocol {
    let modelContainer: ModelContainer
    let modelContext: ModelContext
        
    @MainActor init(modelContainer: ModelContainer) {
        self.modelContainer = modelContainer
        self.modelContext = modelContainer.mainContext
    }
    
    
    @MainActor func save(from user: User) async {
        modelContext.insert(user)
        
        do {
            try await withCheckedThrowingContinuation { continuation in
                DispatchQueue.main.async {
                    do {
                        try self.modelContext.save()
                        print("💾 user 저장완료")
                        continuation.resume()
                    } catch {
                        print("⚠️ [Error] user 저장실패: \(error)")
                        continuation.resume(throwing: error)
                    }
                }
            }
        } catch {
            print("⚠️ [Error] user 저장실패: \(error)")
        }
    }
    
    
    @MainActor func updateUser(from user: User) async {
        do {
            let fetchedUser = await fetchUser()
            
            if let existingUser = fetchedUser {
                existingUser.isFirstLaunch = user.isFirstLaunch
                                
                try modelContext.save()
                print("✅ User 업데이트 완료")
            } else {
                print("⚠️ [Error]: 존재하는 User 데이터가 없습니다.")
            }
        } catch {
            print("[Error] timeSpan 업데이트 실패: \(error)")
        }
    }
    
    
    @MainActor func fetchUser() async -> User? {                
        do {
            let descripter = FetchDescriptor<User>()
                                    
            return try await withCheckedThrowingContinuation{ continuation in
                DispatchQueue.main.async {
                    do {
                        let user = try self.modelContext.fetch(descripter).first
                        print("✅ User fetch가 완료되었습니다.")
                        continuation.resume(returning: user)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                    
                }
            }
        } catch {
            fatalError("⚠️ [Error] User fetch fail: \(error)")
        }
    }
    
    
    
    @MainActor func fetchUsers() async -> [User] {
        do {
            let descripter = FetchDescriptor<User>()
                        
            print("✅ [User] fetch가 완료되었습니다.")
            return try await withCheckedThrowingContinuation{ continuation in
                DispatchQueue.main.async {
                    do {
                        let user = try self.modelContext.fetch(descripter)
                        print("✅ User fetch가 완료되었습니다.")
                        continuation.resume(returning: user)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                    
                }
            }
        } catch {
            fatalError("⚠️ [Error] User fetch fail: \(error)")
        }
    }
        
    @MainActor func delete(from user: User) async {
        do {
            if let userToDelete = await fetchUser() {
                modelContext.delete(user)
                try modelContext.save()
                print("✅ User 삭제완료")
            } else {
                print("⚠️ [Error] 해당 User를 찾을 수 없습니다.")
            }
        } catch {
            print("⚠️ [Error] User 삭제실패: \(error)")
        }
    }
}
