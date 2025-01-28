//
//  ProgressDay.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/28/25.
//

import SwiftUI

struct ProgressDay: View {
    var text: String
    
    var body: some View {
        VStack {
            Text(text)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(Color.white)
                .padding(.horizontal)
                .padding(.vertical, 5)
        }
        .background(Color.black)
        .cornerRadius(20)
        .padding()
    }
}

#Preview {
    ProgressDay(text: "D-365")
}
