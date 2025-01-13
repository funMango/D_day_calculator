//
//  ModeSelectionView.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/13/25.
//

import SwiftUI

enum Mode: String, CaseIterable {
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
    var body: some View {
        NavigationStack {
            VStack {
                Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit")
                    .padding(.vertical)
            }
            .navigationTitle("Choose Mode")
            .padding(.bottom)
            
            
            List {
                ForEach(Mode.allCases, id: \.self) { mode in
                    ModeCell(mode: mode)
                }
            }
            .listStyle(.plain)
            // .listRowSeparator(.hidden)
            .listRowSpacing(10)
            
        }
    }
}

struct ModeCell: View {
    var mode: Mode
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(mode.rawValue)")
                .font(.title2)
                .padding(.bottom, 5)
            Text("\(mode.content)")
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 150, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.blue)
        )
    }
}

#Preview {
    ModeSelectionView()
}
