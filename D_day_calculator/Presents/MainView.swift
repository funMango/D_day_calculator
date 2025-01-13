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
                DetailsScreen(dayInfo: info)
            }
        }
    }
}


struct MainCellView: View {
    var dayInfo: DayInfo
    
    var body: some View {
        HStack {
            Text(dayInfo.title)
                .font(.headline)
            
            Spacer()
            
            Text("\(dayInfo.dDay) days")
        }
    }
}

struct DetailsScreen: View {
    var dayInfo: DayInfo
    var body: some View {
        VStack {
            Text("\(dayInfo.startDay)")
            Text("\(dayInfo.dDay)")
        }
        .navigationTitle("\(dayInfo.title)")
    }
}



#Preview {
    MainView()
}
