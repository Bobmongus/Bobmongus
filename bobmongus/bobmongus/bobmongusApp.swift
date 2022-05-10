//
//  bobmongusApp.swift
//  bobmongus
//
//  Created by ryu hyunsun on 2022/04/06.
//

import SwiftUI

@main
struct bobmongusApp: App {
    
    let modelData = ModelData()
    
    var body: some Scene {
        WindowGroup {
            // 앱을 처음 실행하면 SplashView()를 보여준다.
                        SplashView()
        }
    }
}
