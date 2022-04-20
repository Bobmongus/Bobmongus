
//
//  AuthenticationView.swift
//  bobmongus
//
//  Created by ryu hyunsun on 2022/04/07.
//
import SwiftUI

struct AuthenticationView: View {
    
    //    @StateObject var dataManager = DataManager()
    @State private var email = ""
    @State private var certificationNumber = ""
    @State private var isAuthenticated = false
    @State private var isSendedEmail = false
    @State private var showSendSuccessModal = false
    @State private var showSendFailModal = false
    @State private var showSuccessAuthenticateModal = false
    @State private var showFailAuthenticateModal = false
    
    @State var w = UIScreen.main.bounds.width
    @State var h = UIScreen.main.bounds.height
    
    @EnvironmentObject var modelData: ModelData
//    @StateObject var users = User()
    
    @State private var showButton = false
    
    var body: some View {
        
        VStack {
            
            Image("bobmong")
                .resizable()
                .frame(width: w * 0.4, height: w * 0.4)
                .padding(.bottom, 60.0)
            
            TextField("가입한 이메일", text: $email)
                .modifier(ClearButton(text: $email))
                .disableAutocorrection(true) //MARK: 자동완성 없애주는 친구.
                .autocapitalization(.none)
                .padding(.horizontal, 60.0)
            Divider()
                .frame(width: w * 0.7,height: 1)
            
            VStack {
                Button(action: {
                    
                    for user in modelData.users {
                        let userEmail = user.email
                        if userEmail == email {
                            isSendedEmail = true
                            showSendSuccessModal = true
                            break
                        }
                    }
                    if isSendedEmail == false {
                        showSendFailModal = true
                    }
                    
                }){
                    HStack {
                        Text("인증번호 발송")
                            .font(.custom("DungGeunMo", size: 20))
                    }.padding(15)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .shadow(color:.black, radius: 0, x:2 ,y: 3)
                            .foregroundColor(Color(red: 0.6352941176470588, green: 0.396078431372549, blue: 0.7372549019607844))
                        )
                }
                .foregroundColor(Color.white)
                .alert("인증번호가 발송되었습니다.", isPresented: $showSendSuccessModal){}
                .alert("등록되지 않은 메일입니다. 다시한번 확인해주세요.", isPresented: $showSendFailModal){}
                
            }.padding(.top,15.0)
                .padding(.bottom,20.0)
            
            SecureField("인증번호 작성", text: $certificationNumber)
                .disableAutocorrection(true) //MARK: 자동완성 없애주는 친구.
                .autocapitalization(.none)
                .padding(.horizontal, 60.0)
            Divider()
                .frame(width: w * 0.7,height: 1)
                .padding(.bottom, 15)
            
            
            if showButton == false {
                if isSendedEmail == true {
                    VStack {
                        Button(action: {
                            if certificationNumber == "12345" {
                                isAuthenticated = true
                                showSuccessAuthenticateModal = true
                                showButton = true
                            }
                            else {
                                isAuthenticated = false
                                showFailAuthenticateModal = true
                            }
                        }){
                            HStack{
                                Text("인증하기")
                                    .font(.custom("DungGeunMo",size: 20))
                            }.padding(15)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .shadow(color:.black, radius: 0, x:2 ,y: 3)
                                        .foregroundColor(Color(red: 0.6352941176470588, green: 0.396078431372549, blue: 0.7372549019607844))
                                )
                        }
                        .foregroundColor(Color.white)
                        .alert("인증되었습니다.", isPresented: $showSuccessAuthenticateModal){}
                        .alert("올바르지 않은 인증번호입니다. 다시 입력해주세요.", isPresented: $showFailAuthenticateModal){}
                    }
                }
                else {
                    HStack{
                        Text("인증하기")
                            .font(.custom("DungGeunMo",size: 20))
                    }.padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .shadow(color:.black, radius: 0, x:2 ,y: 3)
                                .foregroundColor(Color(red: 0.771, green: 0.771, blue: 0.779))
                        )
                        .foregroundColor(Color.black)
                }
            }
            
            
            
            else {
                if isAuthenticated == true && email != "" && certificationNumber != "" {
                    NavigationLink(destination: ResetPasswordView(email: email)) {
                        Text("비밀번호 초기화")
                            .font(.custom("DungGeunMo", size: 20))
                            .padding(15)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .shadow(color:.black, radius: 0, x:2 ,y: 3)
                                    .foregroundColor(Color(red: 0.6352941176470588, green: 0.396078431372549, blue: 0.7372549019607844))
                            )
                            .foregroundColor(Color.white)
//                            .padding(.bottom, 300)
                        
                    }
                    .isDetailLink(false)
                }
                else {
                    Text("비밀번호 초기화")
                        .font(.custom("DungGeunMo", size: 20))
                        .padding(15)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .shadow(color:.black, radius: 0, x:2 ,y: 3)
                                .foregroundColor(Color(red: 0.771, green: 0.771, blue: 0.779))
                        )
                        .foregroundColor(Color.black)
//                        .padding(.bottom, 300)
                }
            }
            Spacer().frame(height:170)
        }
        .onAppear(){
            email = ""
            certificationNumber = ""
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView()
            .environmentObject(ModelData())
    }
}
