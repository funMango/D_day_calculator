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
                    .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("Mode")
            .navigationBarTitleDisplayMode(.inline)
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
                    NavigationBackBtn()
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct ModeCell: View {
    var mode: Mode
    
    var body: some View {
        VStack {
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
            
            Divider()
                .background(Color.black)
        }
    }
}

#Preview {
    ModeSelectionView()
        .environmentObject(NavigationPathObject())
}
