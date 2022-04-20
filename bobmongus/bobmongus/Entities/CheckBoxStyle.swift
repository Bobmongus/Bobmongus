//
//  CheckBoxStyle.swift
//  bobmongus
//
//  Created by Hyeonsoo Kim on 2022/04/12.
//

import Foundation
import SwiftUI

struct CheckboxStyle: ToggleStyle { // Checkbox 만들기
    func makeBody(configuration: Self.Configuration) -> some View {
        return HStack {
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 14, height: 14)
                .foregroundColor(configuration.isOn ? .blue : .gray)
                .font(.system(size: 20, weight: .semibold, design: .default))
                configuration.label // 얘 없으면 Label 안들어감
        }
        .onTapGesture { configuration.isOn.toggle() }
    }
}
