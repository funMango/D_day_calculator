//
//  TextInput.swift
//  D_day_calculator
//
//  Created by 이민호 on 1/14/25.
//

import SwiftUI

struct ListTextInput: View {
    @Binding var text: String
    var placeholder: String = ""
    var header: String = ""
    var backgroundColor: Color = .gray.opacity(0.2)
    
    var body: some View {
        VStack {
            
            if !header.isEmpty {
                HStack {
                    Text(header)
                        .font(.caption)
                        .foregroundStyle(.gray)
                    
                    Spacer()
                }
            }
            
            ZStack {
                TextField(placeholder, text: $text)
                    .textFieldStyle(CustomTextFieldStyle(backgroundColor: backgroundColor))
                                                    
                if !text.isEmpty {
                    Button {
                        text = ""
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundStyle(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing) // 오른쪽 정렬
                    .padding(.trailing, 10)
                }
            }
        }
    }
}

struct CustomTextFieldStyle: TextFieldStyle {
    var backgroundColor: Color
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration            
            .frame(maxHeight: 40)
            .background(backgroundColor)
            .cornerRadius(10)
    }
}




#Preview {
    @Previewable @State var text = ""
    ListTextInput(text: $text, placeholder: "placeholder", header: "header")
}
