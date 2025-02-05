//
//  DateDetailView.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/23/25.
//

import SwiftUI

struct DateDetailView: View {
    @EnvironmentObject var navigationPath: NavigationPathObject
    @EnvironmentObject var vmContainer: ViewModelContainer
    @StateObject var viewModel: DateDetailViewModel
    @State var showingComfirm = false
        
    var body: some View {
        VStack {
            HStack {
                Text("\(viewModel.timeSpan.title)")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                
                Spacer()
            }
            .padding()
            
            List {
                DateText(key: "From", value: viewModel.timeSpan.getStartDate())
                
                DateText(key: "To", value: viewModel.timeSpan.getEndDate())
                
                DateText(key: "Result",
                         value: viewModel.timeSpan.calculatedDays,
                         caption: viewModel.timeSpan.mode.caption
                )
            }
            .listStyle(.plain)                                                        
        }
        .navigationTitle("Date Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    navigationPath.path.append(
                        NavigationTarget.datePicker(
                            viewModel: vmContainer.getDateViewModel(
                                mode: viewModel.timeSpan.mode,
                                timeSpan: viewModel.timeSpan
                            ),
                            type: .edit
                        )
                    )
                } label: {
                    Text("Edit")
                        .foregroundStyle(.red)
                }
            }
            
            ToolbarItem(placement: .topBarLeading) {
                NavigationBackBtn()
            }
            
            ToolbarItem(placement: .bottomBar) {
                Button {
                    showingComfirm.toggle()
                } label: {
                    Text("Delete")
                        .font(.headline)
                        .foregroundStyle(.red)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .environmentObject(navigationPath)
        .confirmationDialog("Delete Comfrimation", isPresented: $showingComfirm) {
            Button(role: .destructive) {
                viewModel.deleteDate()
                navigationPath.clear()
            } label: {
                Text("Delete")
                    .foregroundStyle(.red)
            }
        } message: {
            Text("Are you sure?")
        }
    }
}

#Preview {
    let timeSpan = TimeSpan(
        title: "Counting Test Detail",
        selectedDate: Date.getDate(year: 2024, month: 3, day: 1),
        today: Date.getDate(year: 2025, month: 3, day: 1),
        mode: .counting,
        calculatedDays: ""
    )
    
    let repo = DateRepository()
            
    let viewModelContainer = ViewModelContainer(dateRepository: repo)
    
    DateDetailView(viewModel: viewModelContainer.getDateDetailViewModel(timeSpan: timeSpan))
        .environmentObject(NavigationPathObject())
}
