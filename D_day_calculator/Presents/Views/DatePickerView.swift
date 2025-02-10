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
    @FocusState private var isFocused: Bool
    @State var showingSheet = false
    
    var type: DatePickerViewType
                                            
    var body: some View {
        ZStack {
            BackgroundView(isFocused: Binding(
                get: { isFocused },
                set: { isFocused = $0 }
            ))
            
            VStack {
                CalculatedDaysView()
                .padding()
                .padding(.bottom, 30)
                .frame(maxWidth: .infinity)
                            
                LineTextField(text: $viewModel.title, title: "Title")
                .padding(.horizontal)
                .padding(.bottom, 10)
                .focused($isFocused)
                .frame(maxWidth: .infinity)
                
                DateSelectView(showingSheet: $showingSheet)
                .padding(.horizontal)
                .frame(maxWidth: .infinity)
                                                                                            
                Spacer()
                
                Button {
                    switch type {
                        case .create:
                            viewModel.saveDate()
                            navigationPath.clear()
                        case .edit:
                            viewModel.updateDate()
                            navigationPath.back()
                    }
                } label: {
                    SaveBtn(text: "Save")
                }
                .padding()
            }
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
                    .padding(.bottom, -25)
                    
                Text("\nFrom \(today.formatted(DateFormat.USA.rawValue))")
                    .font(.system(size: 20))
                    .fontWeight(.medium)
                
                if let caption = viewModel.mode.caption {
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
                Text(viewModel.mode.dateReference)
                    .fontWeight(.regular)
                
                Spacer()
                
                Button {
                    self.showingSheet.toggle()
                } label: {
                    HStack {
                        Text("\(viewModel.selectedDate.formatted(DateFormat.USA.rawValue))")
                            .fontWeight(.semibold)
                            .foregroundStyle(.text)
                            
                            
                        Image(systemName: "chevron.down")
                            .resizable()
                            .fontWeight(.semibold)
                            .frame(width: 10, height: 7)
                            .foregroundStyle(.text)
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
