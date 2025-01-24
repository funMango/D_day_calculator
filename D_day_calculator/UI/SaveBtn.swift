//
//  ConfirmBtn.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/22/25.
//

import SwiftUI

struct SaveBtn: View {
    let text: String
    
    var body: some View {
        Text(text)
            .foregroundStyle(.white)
            .font(.system(.title3))
            .fontWeight(.semibold)
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .background(Color.black)
            .cornerRadius(10)
    }
}

#Preview {
    SaveBtn(text: "Confirm")
}
