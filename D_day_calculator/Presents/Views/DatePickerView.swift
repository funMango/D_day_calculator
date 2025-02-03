//
//  DatePickerView.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/13/25.
//

import SwiftUI
import SwiftData

enum DatePickerViewType {
    case create
    case edit
}

struct DatePickerView: View {
    @EnvironmentObject var navigationPath: NavigationPathObject
    @StateObject var viewModel: DateViewModel
    @Environment(\.presentationMode) var presentationMode
    @State var showingSheet = false
    var type: DatePickerViewType
                                            
    var body: some View {
        VStack {
            CalculatedDaysView()
            .padding()
            .padding(.bottom, 30)
            .frame(maxWidth: .infinity)
                        
            LineTextField(text: $viewModel.title, title: "Title")
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            DateSelectView(showingSheet: $showingSheet)
            .padding(.horizontal)
                                                                                        
            Spacer()
            
            Button {
                switch type {
                    case .create:
                        viewModel.saveDate()
                    case .edit:
                        viewModel.updateDate()
                }
                
                navigationPath.clear()                                
            } label: {
                SaveBtn(text: "Save")
            }
            .padding()
        }
        .navigationTitle("Date")
        .navigationBarTitleDisplayMode(.inline)
        .environmentObject(viewModel)
        .sheet(isPresented: $showingSheet) {
            DatePickerWheelView(selectedDate: $viewModel.selectedDate)
                .presentationDetents([.fraction(0.4)])
                .environmentObject(viewModel)
                .presentationDragIndicator(.visible)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationBackBtn()
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - CalculatedDaysView
struct CalculatedDaysView: View {
    @EnvironmentObject var viewModel: DateViewModel
    private let today = Date()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(viewModel.calculatedDays)")
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.bottom, -25)
                    
                Text("\nFrom \(today.formatted(DateFormat.USA.rawValue))")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                    .foregroundColor(.black)
                
                if let caption = viewModel.mode?.caption {
                    Text("\(caption)")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
                
            }
            
            Spacer()
        }
    }
}

// MARK: - DateSelectView
struct DateSelectView: View {
    @EnvironmentObject var viewModel: DateViewModel
    @Binding var showingSheet: Bool
    
    var body: some View {
        VStack {
            HStack {
                Text(viewModel.mode?.dateReference ?? Mode.dDay.dateReference)
                    .fontWeight(.regular)
                    .foregroundColor(.black)
                
                Spacer()
                
                Button {
                    self.showingSheet.toggle()
                } label: {
                    HStack {
                        Text("\(viewModel.selectedDate.formatted(DateFormat.USA.rawValue))")
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                            
                        Image(systemName: "chevron.down")
                            .resizable()
                            .fontWeight(.semibold)
                            .frame(width: 10, height: 7)
                            .foregroundStyle(.black)
                    }
                }
            }
            
            Divider()
                .background(Color.black)
        }
    }
}



// MARK: - DatePickerWheelView
struct DatePickerWheelView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var viewModel: DateViewModel
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack {
            if viewModel.mode == .dDay {
                DatePicker(
                    "Select Date",
                    selection: $selectedDate,
                    in: Date()...,
                    displayedComponents: .date
                )
                .labelsHidden()
                .datePickerStyle(.wheel)
            } else {
                DatePicker(
                    "Select Date",
                    selection: $selectedDate,
                    in: ...Date(),
                    displayedComponents: .date
                )
                .labelsHidden()
                .datePickerStyle(.wheel)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        Button {
            self.presentationMode.wrappedValue.dismiss()
            viewModel.calcDateDiff()
        } label: {
            Text("Select")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(Color.black)
                .cornerRadius(10)
                .padding()
        }
    }
}

#Preview {
    let viewModelContainer = ViewModelContainer(dateRepository: DateRepository())
    let viewModel = viewModelContainer.getDateViewModel(mode: .counting)
    
    DatePickerView(viewModel: viewModel, type: .create)
        .environmentObject(NavigationPathObject())
        .environmentObject(viewModel)
}
