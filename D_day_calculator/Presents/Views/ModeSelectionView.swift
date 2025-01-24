//
//  ModeSelectionView.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/13/25.
//

import SwiftUI

struct ModeSelectionView: View {
    @EnvironmentObject var navigationPath: NavigationPathObject
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            List {
                ForEach(Mode.allCases, id: \.self) { mode in
                    Button {
                        navigationPath.path.append(mode)
                    } label: {
                        ModeCellView(mode: mode)
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .navigationTitle("Mode")
            .navigationBarTitleDisplayMode(.inline)
            .navigationDestination(for: Mode.self) { mode in
                switch mode {
                case .dDay:
                    DatePickerView(viewModel: DateViewModel(
                            dateManageInteractor: DateManageInteractor(
                                dateManageService: DateRepository.shared),
                            dateCalcInteractor: DdayCalcInterator(),
                            mode: mode
                        )
                    )
                case .counting:
                    DatePickerView(viewModel: DateViewModel(
                            dateManageInteractor: DateManageInteractor(
                                dateManageService: DateRepository.shared),
                            dateCalcInteractor: CountingCalcInterator(),
                            mode: mode
                        )
                    )
                }
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

// MARK: - ModeCellView

struct ModeCellView: View {
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
