//
//  DatePickerView.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/13/25.

//

import SwiftUI

struct DatePickerView: View {
    @EnvironmentObject var navigationPath: NavigationPathObject
    @EnvironmentObject var viewModel: DateViewModel
    @State private var showingSheet = false
    private var today = Date()
                
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("D\(viewModel.totalDays)")
                        .font(.system(size: 35))
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                        .padding(.bottom, -25)
                        
                    Text("\nfrom \(today.formatted(DateFormat.USA.rawValue))")
                        .font(.system(size: 20))
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                }
                
                Spacer()
            }
            .padding()
            .padding(.bottom, 30)
            .frame(maxWidth: .infinity)
            
            
            VStack {
                TextField("Title", text: $viewModel.title)
                    
                    .onAppear {
                        UITextField.appearance().clearButtonMode = .whileEditing
                    }
                
                Divider()
                    .background(Color.black)
            }
            .padding(.horizontal)
            .padding(.bottom, 10)
            
            VStack {
                HStack {
                    Text(viewModel.mode.rawValue)
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
            .padding(.horizontal)
            
            
            
            
            
                                                
            Spacer()
            
            Button {
                
            } label: {
                Text("Complete")
                    .foregroundStyle(.white)
                    .font(.system(.title3))
                    .fontWeight(.semibold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(Color.black)
                    .cornerRadius(10)
            }
            .padding()
        }
        
        .environmentObject(viewModel)
        .sheet(isPresented: $showingSheet) {
            DatePickerWheelView(selectedDate: $viewModel.selectedDate)
                .presentationDetents([.fraction(0.45)])
        }
        .onChange(of: viewModel.selectedDate) {
            viewModel.calcDateDiff()
        }
    }
}

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
    let dateViewModel = DateViewModel(interactor: DateDiffInteractor())
    DatePickerView()
        .environmentObject(dateViewModel)
        .environmentObject(NavigationPathObject())
}
