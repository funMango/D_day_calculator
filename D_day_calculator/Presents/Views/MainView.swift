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
    
    @State private var searchText = ""
    var filteredDates: [TimeSpan] {
        guard !searchText.isEmpty else { return viewModel.dates }
        return viewModel.dates.filter { $0.title.contains(searchText)}
    }
            
    let dayInfoDummys = DayInfoDummy().dummys
            
    var body: some View {
        NavigationStack(path: $navigationPath.path) {
            VStack {
                List {
                    ForEach(filteredDates, id: \.self) { timeSpan in
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
            .navigationTitle("List")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        navigationPath.path.append("ModeSelectionView")
                    } label: {
                        Image(systemName: "plus.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundStyle(.red)
                    }
                }
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
        .searchable(text: $searchText)
        .environmentObject(navigationPath)
    }
}

// MARK: - ListCell
struct MainCellView: View {
    var timeSpan: TimeSpan
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(timeSpan.title)
                    .font(.headline)
                    .padding(.bottom, 1)
                Text("\(timeSpan.mode.dateReference): \(timeSpan.startDate.formatted(DateFormat.USA.rawValue))")
                    .font(.caption)
                    .foregroundStyle(Color.gray)
            }
            
            Spacer()
            
            Text("\(timeSpan.calculatedDays)")
                .font(.headline)
        }
    }
}

// MARK: - Detail Page (temporary)
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
