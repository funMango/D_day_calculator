//
//  Line.swift
//  D_day_calculator
//
//  Created by 이민호 on 2/10/25.
//

import SwiftUI

struct Line: View {
    var body: some View {
        Divider()
            .frame(height: 2) // 높이를 5로 설정 (굵기 조절)
            .background(Color.line)
    }
}

#Preview {
    Line()
}
