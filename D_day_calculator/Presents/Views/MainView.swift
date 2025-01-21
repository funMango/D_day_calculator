//
//  MainView.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/12/25.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @StateObject private var navigationPath = NavigationPathObject()
    
    let dayInfoDummys = DayInfoDummy().dummys
            
    var body: some View {
        NavigationStack(path: $navigationPath.path) {
            VStack {
                HStack {
                    HStack {
                        TitleText(title: "List")
                        
                        Spacer()
                    }
                    
                    
                    Button {
                        navigationPath.path.append("ModeSelectionView")
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 30, height: 30)                            
                            .foregroundStyle(.red)
                    }
                }
                .padding()
                
                
                List {
                    ForEach(dayInfoDummys, id: \.self) { info in
                        Button {
                            navigationPath.path.append(info)
                        } label: {
                            MainCellView(dayInfo: info)
                        }
                    }
                }
                .listStyle(.plain)
            }
            
            .navigationDestination(for: String.self) { string in
                if string == "ModeSelectionView" {
                    ModeSelectionView()
                }
            }
            .navigationDestination(for: DayInfo.self) { info in
                DayDetailView(dayInfo: info)
            }
        }        
        .environmentObject(navigationPath)        
    }
}

struct MainCellView: View {
    var dayInfo: DayInfo
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(dayInfo.title)
                    .font(.headline)
                Text(dayInfo.targetDate.formatted(DateFormat.USA.rawValue))
                    .font(.caption)
                    .foregroundStyle(Color.gray)
            }
            
            Spacer()
            
            if dayInfo.mode == .dDay {
                Text("D")
            } else {
                Text(" day")
            }
            
        }
    }
}

struct DayDetailView: View {
    var dayInfo: DayInfo
    var body: some View {
        VStack {
            Text("Target Date: \(dayInfo.targetDate)")
            Text("Date Diff: ")
        }
        .navigationTitle("\(dayInfo.title)")
    }
}



#Preview {
    MainView()
}
