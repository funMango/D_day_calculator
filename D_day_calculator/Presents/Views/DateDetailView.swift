//
//  DateDetailView.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/23/25.
//

import SwiftUI

struct DateDetailView: View {
    @EnvironmentObject var navigationPath: NavigationPathObject
    @StateObject var viewModel: DateViewModel
    @State var showingComfirm = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(viewModel.title)
                .font(.title)
                .fontWeight(.semibold)
                .padding()
                .padding(.bottom, 30)
            
            Text(viewModel.calculatedDays)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 2)
            
            Text("\(viewModel.mode?.dateReference ?? "") \(viewModel.selectedDate.formatted(DateFormat.USA.rawValue))")
            
            Spacer()
            Spacer()
        }
        .padding()
        .navigationTitle("Date Detail")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    navigationPath.path.append(
                        NavigationTarget.datePicker(
                            viewModel: self.viewModel,
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
        title: "Test",
        startDate: Date(),
        endDate: Date(),
        mode: .dDay,
        calculatedDays: "D-day"
    )
    
    let viewModel = DateViewModel(
        dateManageInteractor: DateManageInteractor(
            dateManageService: DateRepository.shared),
        dateCalcInteractor: CountingCalcInterator(),
        timeSpan: timeSpan
    )
    
    DateDetailView(viewModel: viewModel)
        .environmentObject(NavigationPathObject())
}
