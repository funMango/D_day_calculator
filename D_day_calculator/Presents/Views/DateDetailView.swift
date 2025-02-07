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
                
                Spacer()
            }
            .padding()
            .padding(.bottom)
            
            VStack {
                DateText(key: "Start Date", value: viewModel.timeSpan.getStartDate())
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                
                DateText(key: "End Date", value: viewModel.timeSpan.getEndDate())
                    .padding(.horizontal)
                    .padding(.bottom, 5)
            }
            
            Divider()
                .padding(.horizontal)
                .padding(.bottom, 4)
            
            HStack() {
                Spacer()
                
                Text("\(viewModel.timeSpan.calculatedDays)")
                    .font(.title)
                    .fontWeight(.semibold)
            }
            .padding(.horizontal)
            
            
            
            
            
                                                
            Spacer()
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
        calculatedDays: "+45 days",
        days: 2
    )
    
    let repo = DateRepository()
            
    let viewModelContainer = ViewModelContainer(dateRepository: repo)
    
    DateDetailView(viewModel: viewModelContainer.getDateDetailViewModel(timeSpan: timeSpan))
        .environmentObject(NavigationPathObject())
}
