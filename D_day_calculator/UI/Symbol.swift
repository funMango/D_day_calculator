//
//  Symbol.swift
//  D_day_calculator
//
//  Created by 이민호 on 2/22/25.
//

import SwiftUI

struct Symbol: View {
    var name: String
    var size: CGFloat
    var color: Color
    
    var body: some View {
        Image(systemName: "\(name)")
            .resizable()
            .frame(width: size, height: size)
            .foregroundStyle(color)
    }
}

