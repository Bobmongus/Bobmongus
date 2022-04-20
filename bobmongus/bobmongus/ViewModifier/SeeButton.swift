//
//  SeeButton.swift
//  bobmongus
//
//  Created by Hyeonsoo Kim on 2022/04/14.
//

import SwiftUI

struct SeeButton: View {
    
    @Binding var showPassword: Bool
    @Binding var password: String
    
    //Why public?
    var body: some View {

        if !password.isEmpty {
            
            Button {
                
                self.showPassword.toggle()
                
            } label: {
                
                if showPassword {
                    Image(systemName: "eye.slash")
                        .foregroundColor(.secondary)
                } else {
                    Image(systemName: "eye")
                        .foregroundColor(.secondary)
                }
            }
            .padding(.trailing, 10)
        }
    }
}
