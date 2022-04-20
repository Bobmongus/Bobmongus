//
//  ClearButton.swift
//  Tamongus
//
//  Created by Hyeonsoo Kim on 2022/04/08.
//

import SwiftUI

struct ClearButton: ViewModifier {
    
    @Binding var text: String
    
    //Why public?
    public func body(content: Content) -> some View {
        
        ZStack(alignment: .trailing) {
            
            content
            
            if !text.isEmpty {
                Button {
                    self.text = ""
                } label: {
//                    Image(systemName: "delete.left")
//                        .foregroundColor(.secondary)
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(Color(UIColor.opaqueSeparator))
                    
                }
                .padding(.trailing, 10)
            }
        }
    }
}
