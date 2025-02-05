//
//  MainView.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/12/25.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @EnvironmentObject var navigationPath: NavigationPathObject
    @EnvironmentObject var vmContainer: ViewModelContainer
    @StateObject var viewModel: DatesViewModel
            
    var body: some View {
        NavigationStack(path: $navigationPath.path) {
            VStack {
                HStack {
                    Text("Home")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Spacer()
                                                                                
                    Button {
                        navigationPath.path.append(NavigationTarget.modeSelection)
                    } label: {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.red)
                    }
                }
                .padding()
                
                if viewModel.dates.isEmpty {
                    Text("No Events")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.lightGray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.bottom, 30)                    
                } else {
                    List {
                        ForEach(viewModel.dates, id: \.self) { timeSpan in
                            Button {
                                navigationPath.path.append(
                                    NavigationTarget.dateDetail(viewModel: vmContainer.getDateDetailViewModel(timeSpan: timeSpan))
                                )
                            } label: {
                                MainCellView(timeSpan: timeSpan)
                            }
                        }
                        .onDelete(perform: viewModel.deleteDate)
                    }
                    .listStyle(.plain)
                    .refreshable() {
                        viewModel.updateDates()
                    }
                }
            }
            .navigationDestination(for: NavigationTarget.self) { target in
                switch target {
                case .modeSelection:
                    ModeSelectionView()
                case .datePicker(let viewModel, let type):
                    DatePickerView(viewModel: viewModel, type: type)
                case .dateDetail(let viewModel):
                    DateDetailView(viewModel: viewModel)
                }
            }
        }
        .environmentObject(navigationPath)
        .environmentObject(vmContainer)
    }
}

// MARK: - ListCell
struct MainCellView: View {
    var timeSpan: TimeSpan
    
    init(timeSpan: TimeSpan) {
        self.timeSpan = timeSpan
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(timeSpan.title)
                    .font(.headline)
                    .padding(.bottom, 1)
                Text("\(timeSpan.mode.dateReference) \(timeSpan.selectedDate.formatted(DateFormat.USA.rawValue))")
                    .font(.caption)
                    .foregroundStyle(Color.gray)
            }
            
            Spacer()
            
            ProgressDay(text: timeSpan.calculatedDays)
        }
    }
}

#Preview {    
    let viewModelContainer = ViewModelContainer(dateRepository: DateRepository())
    
    MainView(viewModel: viewModelContainer.getDatesViewModel())
        .environmentObject(NavigationPathObject())
        .environmentObject(viewModelContainer)
}
