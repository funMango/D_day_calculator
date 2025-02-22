//
//  SettingListCell.swift
//  D_day_calculator
//
//  Created by 이민호 on 2/22/25.
//

import SwiftUI

struct SettingListCell: View {
    var symbol: String
    var text: String
    
    var body: some View {
        HStack {
            Image(systemName: symbol)
                .foregroundStyle(.backButton)
            
            Text(text)
                .foregroundStyle(.backButton)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundStyle(.lightSilver)
        }
    }
}
