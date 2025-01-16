//
//  MainView.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/12/25.
//

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = DateViewModel(interactor: DateDiffInteractor())
    @State private var path = NavigationPath()
    let dayInfoDummys = DayInfoDummy().dummys
    
    
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                HStack {
                    HStack {
                        Text("List")
                            .font(.system(size: 35))
                            .fontWeight(.bold)
                        
                        Spacer()
                    }
                    .padding()
                    
                    Button {
                        path.append("ModeSelectionView")
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .padding()
                            .foregroundStyle(.red)
                    }
                }
                
                
                List {
                    ForEach(dayInfoDummys, id: \.self) { info in
                        Button {
                            path.append(info)
                        } label: {
                            MainCellView(dayInfo: info)
                        }
                    }
                }
                .listStyle(.plain)
            }
            
            .navigationDestination(for: String.self) { string in
                if string == "ModeSelectionView" {
                    ModeSelectionView(path: $path)
                }
            }
            .navigationDestination(for: DayInfo.self) { info in
                DayDetailView(path: $path, dayInfo: info)
            }
        }
        .environmentObject(viewModel)
    }
}

struct NextView: View {
    @Binding var path: NavigationPath
    
    var body: some View {
        Text("NextView")
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
                Text("D\(dayInfo.calcDateDiff())")
            } else {
                Text("\(dayInfo.calcDateDiff()) day")
            }
            
        }
    }
}

struct DayDetailView: View {
    @Binding var path: NavigationPath
    
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
