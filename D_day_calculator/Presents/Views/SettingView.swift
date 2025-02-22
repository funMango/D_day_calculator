//
//  SettingView.swift
//  D_day_calculator
//
//  Created by 이민호 on 2/22/25.
//

import SwiftUI
import SafariServices

struct SettingView: View {
    @State private var selectedURL: IdentifiableURL? = nil
    
    var body: some View {
        List {
            Section() {
                Button {
                    if let url = URL(string: Policy.privacy.url) {
                        selectedURL = IdentifiableURL(url: url)
                    }
                } label: {
                    SettingListCell(symbol: "lock.document", text: "Privacy policy")
                }
                
                Button {
                    if let url = URL(string: Policy.terms.url) {
                        selectedURL = IdentifiableURL(url: url)
                    }
                } label: {
                    SettingListCell(symbol: "text.document", text: "Terms of service")
                }
            }
            
            // 추후 추가 예정
//            Section() {
//                HStack {
//                    Image(systemName: "a.circle")
//                        .foregroundStyle(.backButton)
//                    
//                    Text("Language")
//                    
//                    Spacer()
//                    
//                    Text("English")
//                        .fontWeight(.semibold)
//                        .foregroundStyle(.red)
//                }
//            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                NavigationBackBtn()
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationTitle("Setting")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $selectedURL) { identifiableURL in
            SafariView(url: identifiableURL.url)
        }
        
    }
}

// Identifiable을 준수하는 구조체
struct IdentifiableURL: Identifiable {
    let id = UUID()
    let url: URL
}
struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // 필요 시 업데이트
    }
}

#Preview {
    SettingView()
}
