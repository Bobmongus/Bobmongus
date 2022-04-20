//
//  ConfirmationDialog.swift
//  Tamongus
//
//  Created by Hyeonsoo Kim on 2022/04/08.
//

import SwiftUI

struct ConfirmationDia: ViewModifier {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var confirmationShown: Bool
    
    func body(content: Content) -> some View {
        
        content
            .confirmationDialog(
                "나가시겠습니까?",
                isPresented: $confirmationShown,
                titleVisibility: .visible) {
                    
                    Button("나가기", role: .destructive) {
                        self.presentationMode.wrappedValue.dismiss()
                    }
                    
                    Button("취소", role: .cancel) {
                        confirmationShown = false
                    }
                }
    }
}
