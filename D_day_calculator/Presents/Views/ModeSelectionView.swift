//
//  ModeSelectionView.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/13/25.
//

import SwiftUI

struct ModeSelectionView: View {
    @EnvironmentObject var navigationPath: NavigationPathObject
    @StateObject var viewModel = DateViewModel(
        dateManageInteractor: DateManageInteractor(
            dateManageService: DateRepository.shared
        )
    )
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            VStack {
                HStack {
                    TitleText(title: "Mode")
                    
                    Spacer()
                }
            }
            .padding()
            
            List {
                ForEach(Mode.allCases, id: \.self) { mode in
                    Button {
                        navigationPath.path.append(mode)
                        
                        switch mode {
                        case .dDay:
                            viewModel.set(mode: mode, calcInteractor: DdayCalcInterator())
                        case .counting:
                            viewModel.set(mode: mode, calcInteractor: CountingCalcInterator())
                        }
                    } label: {
                        ModeCell(mode: mode)
                    }
                }
            }
            .navigationDestination(for: Mode.self) { mode in
                DatePickerView()
                    .environmentObject(viewModel)
            }
            .environmentObject(navigationPath)
            .listStyle(.plain)
            .listRowSeparator(.hidden)
            .listRowSpacing(15)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.black)
                            .fontWeight(.medium)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ModeCell: View {
    var mode: Mode
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(mode.rawValue)")
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding(.bottom, 5)
                Text("\(mode.content)")
                    .foregroundStyle(.gray)
            }
            .padding(.vertical)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 20, weight: .medium))                
        }
        
    }
}

#Preview {
    ModeSelectionView()
        .environmentObject(NavigationPathObject())
}
