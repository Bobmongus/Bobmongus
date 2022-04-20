//
//  PrivacyPolicyView.swift
//  LoginTest
//
//  Created by Chicken on 2022/04/06.
//
import SwiftUI

struct PrivacyPolicyView: View {
//    @ObservedObject var user: User
    
    @State private var isAgree1: Bool = false
    @State private var isDisagree1: Bool = false
    @State private var isAgree2: Bool = false
    @State private var isDisagree2: Bool = false
    
    @State private var showingSignUpView: Bool = false
    @State private var showingAlert: Bool = false
    
    func agreeCheck(checkbox1: Bool, checkbox2: Bool) {
        if checkbox1 == true {
            if checkbox2 == true {
                showingSignUpView = true
                showingAlert = false
            } else {
                showingAlert = true
            }
        } else {
            showingAlert = true
        }
    }
    
    var body: some View {
        VStack {
            PrivacyPolicyBoxView(isAgree: $isAgree1, isDisAgree: $isDisagree1)
            PrivacyPolicyBoxView(isAgree: $isAgree2, isDisAgree: $isDisagree2)
            
            Button("다음") {
                agreeCheck(checkbox1: isAgree1, checkbox2: isAgree2)
            }
            .font(.custom("DungGeunMo", size: 20))
            .foregroundColor(.white)
            .frame(width: 135, height: 50)
            .background(Color(red: 0.6352941176470588, green: 0.396078431372549, blue: 0.7372549019607844))
            .cornerRadius(8)
            .shadow(color:.black, radius: 0, x:2 ,y: 3)
            .padding()
            
            NavigationLink(destination: SignUpView().navigationTitle("회원가입").navigationBarTitleDisplayMode(.inline), isActive: $showingSignUpView) {
                EmptyView()
            }
            .isDetailLink(false)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("알림"), message: Text("약관에 모두 동의해주세요."), dismissButton: .default(Text("닫기")))
            
            }
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
            .environmentObject(ModelData())
    }
}
