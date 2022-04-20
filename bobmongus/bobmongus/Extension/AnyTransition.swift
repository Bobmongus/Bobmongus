//
//  AnyTransition.swift
//  Tamongus
//
//  Created by Hyeonsoo Kim on 2022/04/11.
//

import SwiftUI

extension AnyTransition {
    static var linkTransition: AnyTransition {
        
        AnyTransition.asymmetric(
            
            insertion: AnyTransition.opacity.combined(with: move(edge: .bottom)),
            removal: AnyTransition.move(edge: .bottom).combined(with: .opacity)
            
        )
    }
}
