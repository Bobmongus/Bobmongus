//
//  EntranceView.swift
//  LoginTest
//
//  Created by Chicken on 2022/04/06.
//
import SwiftUI

struct EntranceView: View {
    
    @State private var isActive: Bool = false
    @EnvironmentObject var modelData: ModelData
    
    var body: some View {
        
        NavigationView {
            VStack {                // 이미지
                Image("bobmong")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                    .padding()
                    .padding(.bottom, 10)

                GifImage2("logo-login-shadow")
                    .frame(width: 360, height: 80)
                
                // 로그인 버튼
                NavigationLink(isActive: $isActive) {
                    LoginView()
                        .navigationBarHidden(true)
                } label: {
                    EmptyView()
                }
                .isDetailLink(false)
                
                Button {
                    isActive.toggle()
                } label: {
                    Text("로그인")
                }
                .font(.custom("DungGeunMo", size: 20))
                .foregroundColor(.black)
                .frame(width: 135, height: 50)
                .background(Color(red: 0.937, green: 0.937, blue: 0.942))
                .cornerRadius(8)
                .shadow(color:.black, radius: 0, x:2 ,y: 3)
                .padding(.bottom, 5)

                
                // 회원가입 버튼
                NavigationLink(destination: PrivacyPolicyView().navigationTitle("개인정보이용동의").navigationBarTitleDisplayMode(.inline)) {
                        Text("회원가입")
                }
                .isDetailLink(false)
                .font(.custom("DungGeunMo", size: 20))
                .foregroundColor(.white)
                .frame(width: 135, height: 50)
                .background(Color(red: 0.6352941176470588, green: 0.396078431372549, blue: 0.7372549019607844))
                .cornerRadius(8)
                .shadow(color:.black, radius: 0, x:2 ,y: 3)
                
            }
            .offset(y: -50)
            .onAppear { //check
                if modelData.myProfile.isLogin {
                    isActive = true
                }
            }
        }
        .environment(\.rootPresentationMode, self.$isActive)
    }
}

struct EntranceView_Previews: PreviewProvider {
    static var previews: some View {
        EntranceView()
            .environmentObject(ModelData())
    }
}
