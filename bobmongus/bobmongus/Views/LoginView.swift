//
//  LoginView.swift
//  LoginTest
//
//  Created by Chicken on 2022/04/04.
//
import SwiftUI

struct LoginView: View {
//    @ObservedObject var user: User
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @EnvironmentObject var modelData: ModelData
    
    @State private var isStored = false
    @State private var showingMainView = false
    @State private var showingAlert = false
    
    @State private var isActive: Bool = false
    
    func authenticateUser(email: String, password: String) {
        for i in modelData.users.indices {
            if email.lowercased() == modelData.users[i].email.lowercased() && password.lowercased() == modelData.users[i].password.lowercased() {
                
                modelData.users[i].isLogin = true
                modelData.users[i].isReady = false
                modelData.users[i].isMakingRoom = false
                
                modelData.myProfile = modelData.users[i]
                
//                self.isActive = true
                
                showingMainView = true
                showingAlert = false
                
                self.email = ""
                self.password = ""
                
                return
            }
        }
        showingAlert = true
    }
    
    var body: some View {
        
        let width = UIScreen.main.bounds.width / 390 * 285
        let height = UIScreen.main.bounds.height / 844 * 40
        
        VStack {
            GifImage("bob")
                .frame(width: 128, height: 128)
//                .scaledToFill()
//            Image("bobmong")
//                .resizable()
//                .scaledToFit()
//                .frame(width: 128, height: 128)
//                .padding(.bottom, 30)
            
            VStack(alignment: .leading) {
                
                TextField("email", text: $email)
                    .modifier(ClearButton(text: $email))
                    .disableAutocorrection(true) //MARK: 자동완성 없애주는 친구.
                    .autocapitalization(.none) //MARK: 첫 글자 대문자 안나오게.
                    .padding()
                    .frame(width: width, height: height)
                    .background(RoundedRectangle(cornerRadius: 6)
                        .stroke(.gray, lineWidth: 0.2))
                    .padding(.bottom, 5)
                
                SecureField("password", text: $password)
                    .disableAutocorrection(true) //MARK: 자동완성 없애주는 친구.
                    .autocapitalization(.none)
                    .padding()
                    .frame(width: width, height: height)
                    .background(RoundedRectangle(cornerRadius: 6)
                        .stroke(.gray, lineWidth: 0.2))
                    .padding(.top, 5)
            
                    
                
                Toggle(isOn: $isStored) {
                    Text("로그인 정보 저장")
                        .font(.custom("DungGeunMo", size: 15))
                }
                .toggleStyle(CheckboxStyle())
                .padding()
                .offset(x: -13)
            }
            
            VStack {
                Button("로그인") {
                    authenticateUser(email: email, password: password)
                }
                .font(.custom("DungGeunMo", size: 20))
                .foregroundColor(.white)
                .frame(width: 155, height: 50)
                .background(Color(red: 0.6352941176470588, green: 0.396078431372549, blue: 0.7372549019607844))
                .cornerRadius(8)
                .shadow(color:.black, radius: 0, x:2 ,y: 3)
                .padding()
                
                
                NavigationLink(isActive: $showingMainView, destination: {
                    TestRoomListView()
                        .navigationBarHidden(true)
                }, label: {
                    EmptyView()
                })
                .isDetailLink(false)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("알림"), message: Text("이메일과 비밀번호를 확인해주세요."), dismissButton: .default(Text("닫기")))
                }
                
                NavigationLink(destination: AuthenticationView(), isActive: $isActive) {
                    Text("비밀번호 찾기")
                        .font(.custom("DungGeunMo", size: 15))
                        .foregroundColor(.secondary)
                        .frame(width: 105, height: 22)
                        .padding(5)
                }
                .isDetailLink(false)
                
                NavigationLink(destination: PrivacyPolicyView()
                    .navigationTitle("개인정보이용동의")
                    .navigationBarTitleDisplayMode(.inline))
                {
                    Text("계정이 없다면? 회원가입 하러가기")
                        .font(.custom("DungGeunMo", size: 15))
                        .foregroundColor(.secondary)
                        .frame(width: 242, height: 22)
                        .padding(5)
                }
                .isDetailLink(false)
            }
        }
        .navigationBarHidden(true)
        .offset(y: -50)
        .onAppear {
            if modelData.myProfile.isLogin {
                showingMainView = true
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(ModelData())
    }
}
