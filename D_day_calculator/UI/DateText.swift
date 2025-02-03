//
//  DateText.swift
//  D_day_calculator
//
//  Created by 이민호 on 2/3/25.
//

import SwiftUI

struct DateText: View {
    var key: String
    var value: String
    var caption: String? = nil
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(key)
                
                
                if let caption = caption {
                    Text(caption)
                        .foregroundStyle(.gray)
                        .font(.caption)
                }
            }
            
            Spacer()
            
            Text(value)
                .fontWeight(.medium)
        }
    }
}

#Preview {
    DateText(
        key: "From",
        value: "Jan 1, 2025",
        caption: "Include end date in calculation"
    )
}
