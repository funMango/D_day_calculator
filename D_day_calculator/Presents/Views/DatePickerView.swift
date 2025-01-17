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
                
    var body: some View {
        VStack {
            HStack {
                Text("Date Selection")
                    .font(.system(size: 35))
                    .fontWeight(.bold)
                
                Spacer()
            }
            .padding()
            
            Spacer()
            
            Text("\(viewModel.totalDays)")
                .font(.system(size: 50))
                .fontWeight(.bold)
                .padding(.top, 50)
                .padding(.bottom, 50)
                .foregroundStyle(Color.red)
                
            List {
                TextField("Title", text: $viewModel.title)
                    .onAppear {
                        UITextField.appearance().clearButtonMode = .whileEditing
                    }
                                                    
                HStack {
                    Text("Date")
                        .fontWeight(.regular)
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    Button {
                        self.showingSheet.toggle()
                    } label: {
                        HStack {
                            Text("\(viewModel.selectedDate.formatted(DateFormat.USA.rawValue))")
                                .fontWeight(.semibold)
                                
                            Image(systemName: "chevron.down")
                                .resizable()
                                .fontWeight(.semibold)
                                .frame(width: 10, height: 7)
                        }
                    }
                }
            }
            .listStyle(.plain)
            
            Spacer()
        }
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
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack {
            DatePicker(
                "Select Date",
                selection: $selectedDate,
                displayedComponents: .date
            )
            .labelsHidden()
            .datePickerStyle(.wheel)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        Button {
            self.presentationMode.wrappedValue.dismiss()
        } label: {
            Text("Select")
                .font(.title3)
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
    DatePickerView()
}
