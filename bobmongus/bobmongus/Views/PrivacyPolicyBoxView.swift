//
//  PrivacyPolicyBoxView.swift
//  bobmongus
//
//  Created by Hyeonsoo Kim on 2022/04/12.
//

import SwiftUI

struct PrivacyPolicyBoxView: View {
    @Binding var isAgree: Bool
    @Binding var isDisagree: Bool
    
    init(isAgree: Binding<Bool> = .constant(false), isDisAgree: Binding<Bool> = .constant(false)) {
        _isAgree = isAgree
        _isDisagree = isDisAgree
    }
    
    var body: some View {
        VStack {
            TextInRectangleView()
            HStack {
                Toggle(isOn: $isAgree) {
                    Text("예, 동의합니다")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                }
                .toggleStyle(CheckboxStyle())
                .padding()
                .onChange(of: isAgree) { isAgree in
                    if isAgree {
                        isDisagree = false
                    } else {
                        isDisagree = true
                    }
                }
            Toggle(isOn: $isDisagree) {
                    Text("아니오, 동의하지 않습니다")
                        .font(.system(size: 14))
                        .foregroundColor(.black)
                }
                .toggleStyle(CheckboxStyle())
                .padding()
                .onChange(of: isDisagree) { isDisagree in
                    if isDisagree {
                        isAgree = false
                    } else {
                        isAgree = true
                    }
                    
                }
            }
        }
    }
}

struct PrivacyPolicyBoxView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyBoxView()
            .environmentObject(ModelData())
    }
}
