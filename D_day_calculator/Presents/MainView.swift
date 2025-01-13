//
//  MainView.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/12/25.
//

import SwiftUI

struct MainView: View {
    let dayInfoDummys = DayInfoDummy().dummys
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(dayInfoDummys, id: \.self) { info in
                    NavigationLink(value: info) {
                        MainCellView(dayInfo: info)
                    }
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("List")
            .navigationDestination(for: DayInfo.self) { info in
                DayDetailView(dayInfo: info)
            }
        }
    }
}


struct MainCellView: View {
    var dayInfo: DayInfo
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(dayInfo.title)
                    .font(.headline)
                Text(dayInfo.getTargetDate())
                    .font(.caption)
                    .foregroundStyle(Color.gray)
            }
            
            Spacer()
            
            if dayInfo.mode == .dDay {
                Text("D\(dayInfo.calcDateDiff())")
            } else {
                Text("\(dayInfo.calcDateDiff()) day")
            }
            
        }
    }
}

struct DayDetailView: View {
    var dayInfo: DayInfo
    var body: some View {
        VStack {
            Text("Target Date: \(dayInfo.targetDate)")
            Text("Date Diff: \(dayInfo.calcDateDiff())")
        }
        .navigationTitle("\(dayInfo.title)")
    }
}



#Preview {
    MainView()
}
