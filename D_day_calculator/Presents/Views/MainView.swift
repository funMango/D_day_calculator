//
//  MainView.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/12/25.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @StateObject private var navigationPath = NavigationPathObject()
    @StateObject private var viewModel = DatesViewModels(
        dateManager: DateManageInteractor(
            dateManageService: DateRepository.shared
        )
    )
        
    let dayInfoDummys = DayInfoDummy().dummys
            
    var body: some View {
        NavigationStack(path: $navigationPath.path) {
            VStack {
                HStack {
                    HStack {
                        TitleText(title: "List")
                        
                        Spacer()
                    }
                    
                    
                    Button {
                        navigationPath.path.append("ModeSelectionView")
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)                            
                            .foregroundStyle(.red)
                    }
                }
                .padding()
                
                
                List {
                    ForEach(viewModel.dates, id: \.self) { timeSpan in
                        Button {
                            navigationPath.path.append(timeSpan)
                        } label: {
                            MainCellView(timeSpan: timeSpan)
                        }
                    }
                    .onDelete(perform: viewModel.deleteDate)
                }
                .listStyle(.plain)
                
            }
            
            .navigationDestination(for: String.self) { string in
                if string == "ModeSelectionView" {
                    ModeSelectionView()
                }
            }
            .navigationDestination(for: TimeSpan.self) { timeSpan in
                DayDetailView(timeSpan: timeSpan)
            }
        }        
        .environmentObject(navigationPath)        
    }
}

struct MainCellView: View {
    var timeSpan: TimeSpan
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(timeSpan.title)
                    .font(.headline)
                Text(timeSpan.startDate.formatted(DateFormat.USA.rawValue))
                    .font(.caption)
                    .foregroundStyle(Color.gray)
            }
            
            Spacer()
            
            Text("\(timeSpan.calculatedDays)")
        }
    }
}

struct DayDetailView: View {
    var timeSpan: TimeSpan
    var body: some View {
        VStack {
            Text("\(timeSpan.calculatedDays)")
            Text("\(timeSpan.startDate.formatted(DateFormat.USA.rawValue))")
        }
        .navigationTitle("\(timeSpan.title)")
    }
}



#Preview {
    MainView()
}
