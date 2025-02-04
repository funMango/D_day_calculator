//
//  BackgroundView.swift
//  D_day_calculator
//
//  Created by 이민호 on 2/4/25.
//

import SwiftUI

struct BackgroundView: View {
    @Binding var isFocused: Bool
        
    var body: some View {
        Color(.systemBackground)
            .ignoresSafeArea()
            .onTapGesture {
                isFocused = false
            }
    }
}
