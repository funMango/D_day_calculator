//
//  TitleText.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/18/25.
//

import SwiftUI

struct TitleText: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 35))
            .fontWeight(.bold)
    }
}

#Preview {
    TitleText(title: "List")
}
