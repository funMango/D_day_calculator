//
//  NavigationBackBtn.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/18/25.
//

import SwiftUI

struct NavigationBackBtn: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
        } label: {
            HStack {
                Image(systemName: "chevron.left")
                    .foregroundStyle(.black)
                    .fontWeight(.medium)
            }
        }
    }
}

#Preview {
    NavigationBackBtn()
}
