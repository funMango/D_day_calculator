//
//  D_day_calculatorApp.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/12/25.
//

import SwiftUI
import SwiftData

@main
struct D_day_calculatorApp: App {
    @StateObject var navigationPath = NavigationPathObject()
    @StateObject var vmContainer = ViewModelContainer(dateRepository: DateRepository())
    
    var body: some Scene {        
        WindowGroup {            
            MainView(viewModel: vmContainer.getDatesViewModel())
                .environmentObject(navigationPath)
                .environmentObject(vmContainer)
                .onAppear(){
                    // printAllData(DateRepository())
                }
        }
    }
    
// MARK: - SwiftData 확인
    @MainActor
    func printAllData(_ dataRepo: DateRepoProtocol) {
        let fetched = dataRepo.fetchDate()
        
        for data in fetched {
            print(data)
        }
    }
}
