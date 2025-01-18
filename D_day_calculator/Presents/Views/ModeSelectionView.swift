//
//  ModeSelectionView.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/13/25.
//

import SwiftUI

enum Mode: String, CaseIterable, Hashable {
    case dDay = "D-day"
    case counting = "Counting"
            
    var content: String {
        switch self {
        case .dDay:
            return "Choose D-Day from today"
        case .counting:
            return "Counting day from specified date"
        }
    }        
}

struct ModeSelectionView: View {
    @EnvironmentObject var navigationPath: NavigationPathObject
    @EnvironmentObject var viewModel: DateViewModel
    
    var body: some View {
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
                        viewModel.selectMode(from: mode)
                    } label: {
                        ModeCell(mode: mode)
                    }
                }
            }
            .navigationDestination(for: Mode.self) { mode in
                DatePickerView()
            }
            .environmentObject(navigationPath)
            .listStyle(.plain)
            .listRowSeparator(.hidden)
            .listRowSpacing(15)
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

struct TestView: View {
    var mode: Mode
    
    var body: some View {
        Text(mode.rawValue)
    }
}

#Preview {    
    let dateViewModel = DateViewModel(interactor: DateDiffInteractor())
    ModeSelectionView()
        .environmentObject(dateViewModel)
        .environmentObject(NavigationPathObject())
}
