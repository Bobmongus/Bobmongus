//
//  SplashView.swift
//  bobmongus
//
//  Created by baek seohyeon on 2022/04/26.
//

import SwiftUI

struct SplashView: View {
    @State var isActivate = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    let modelData = ModelData()
    
    var body: some View {
        if isActivate { // Splash가 나타난 이후부턴 ContentView()를 보여준다.
            ContentView()
                .environmentObject(modelData)
        }
        else {  // 처음 실행되었다면 Splash를 보여준다.
            ZStack{
                Image("bobmong")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .scaleEffect(size)
                    .opacity(opacity)
                    // 이미지에 나타나면 선명해지면서 확대하는 애니메이션 적용
                    .onAppear {
                        // 1.2초안에 size(0.8->1.2), opacity(0.5->1.0)
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 1.2
                            self.opacity = 1.00
                        }
                    }
            }
            // Splash 화면이 나타났다면 isActivate를 ture로 바꾸어준다.
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation {
                        self.isActivate = true
                    }
                }
            }
            
        }
        
    }
}
struct SplashView_Previews: PreviewProvider {
    static var previews: some View {
        SplashView()
    }
}
