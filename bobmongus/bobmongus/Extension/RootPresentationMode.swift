//
//  RootPresentationMode.swift
//  bobmongus
//
//  Created by Hyeonsoo Kim on 2022/04/12.
//
import SwiftUI

struct RootPresentationModeKey: EnvironmentKey {
    static let defaultValue: Binding<RootPresentationMode> = .constant(RootPresentationMode())
}

extension EnvironmentValues {
    var rootPresentationMode: Binding<RootPresentationMode> {
        get { return self[RootPresentationModeKey.self]}
        set { self[RootPresentationModeKey.self] = newValue}
    }
}

typealias RootPresentationMode = Bool

public extension RootPresentationMode {
    mutating func dismiss() {
        self.toggle()
    }
}
