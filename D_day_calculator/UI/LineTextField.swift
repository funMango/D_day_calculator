//
//  TitleText.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/18/25.
//

import SwiftUI

struct LineTextField: View {
    @Binding var text: String
    var title: String
    
    var body: some View {
        VStack {
            TextField(title, text: $text)
                .keyboardType(.default)
                .autocorrectionDisabled(true)
                .onAppear {
                    DispatchQueue.main.async {
                        UITextField.appearance().clearButtonMode = .whileEditing                        
                    }
                }
            
            Divider()
                .background(Color.black)
        }
        
    }
}


