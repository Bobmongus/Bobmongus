////
////  TestLoginView.swift
////  Tamongus
////
////  Created by Hyeonsoo Kim on 2022/04/12.
////
//
//import SwiftUI
//
//struct TestLoginView: View {
//
//    @EnvironmentObject var modelData: ModelData
//
//    @State private var email: String = ""
//    @State private var password: String = ""
//    @State private var showPassword: Bool = false
//
//    //MARK: pop to root
//    @State private var isUser: Bool = false
//
//    var emails: [String] {
//        modelData.users.map { $0.email }
//    } //If user's email is not here, it is a wrong email.
//
//    var body: some View {
//        NavigationView {
//            VStack {
//
//                TextField("Enter Email", text: $email)
//                    .textFieldStyle(.roundedBorder)
//                    .modifier(ClearButton(text: $email))
//
//                ZStack(alignment: .trailing) {
//
//                    if showPassword {
//                        TextField("Enter Password", text: $password)
//                            .textFieldStyle(.roundedBorder)
//                    } else {
//                        SecureField("Enter Password", text: $password)
//                            .textFieldStyle(.roundedBorder)
//                    }
//
////                    SeeButton(showPassword: $showPassword, password: $password)
//
//                    if !password.isEmpty {
//
//                        Button(action: {
//
//                            self.showPassword.toggle()
//
//                        }, label: {
//
//                            if showPassword {
//                                Image(systemName: "eye.slash")
//                                    .foregroundColor(.secondary)
//                            } else {
//                                Image(systemName: "eye")
//                                    .foregroundColor(.secondary)
//                            }
//
//                        })
//                        .padding(.trailing, 10)
//                    }
//                }
//
//                NavigationLink(isActive: $isUser) { //MARK: pop to root
//                    TestRoomListView()
//                        .navigationBarHidden(true)
//                } label: {
//                    EmptyView()
//                }
//                .isDetailLink(false) //MARK: pop to root
//
//                Button("로그인") {
//                    if emails.contains(self.email) { //email 일치.
//
//                        let userIndex: Int = {
//                            modelData.users.firstIndex {
//                                $0.email == email
//                            }!
//                        }()
//
//                        if modelData.users[userIndex].password == password { //password 일치.
//
//                            modelData.users[userIndex].isLogin = true
//                            modelData.users[userIndex].isReady = false //why -> go contentview
//                            modelData.users[userIndex].isMakingRoom = false //also
//
//                            modelData.myProfile = modelData.users[userIndex] //myProfile에 할당.
//
//                            print(modelData.myProfile)
//
//                            self.isUser = true
//
//                            self.email = ""
//                            self.password = ""
//
//                        } else { //password 불일치.
//
//                            print("비밀번호가 틀렸습니다.")
//
//                        }
//
//                    } else { //email 불일치.
//
//                        print("등록되어있지않은 이메일입니다.")
//
//                    }
//                }
//            }
//            .padding()
//            .onAppear { //check
//                if modelData.myProfile.isLogin {
//                    isUser = true
//                } //MARK: 이렇게 UserDefaults를 이용하면, Auto Login도 쉽게 구현이 가능할 듯.
//                //이론상, 앱을 끈 후에도 원래 있던 방으로 바로 이동시킬 수도 있긴할듯하다.
//                //하지만 남은 시간이 얼마 안되니, 일단 여기까지만.
//            }
//        }
//        //MARK: pop to root
////        .navigationViewStyle(StackNavigationViewStyle())
//        .environment(\.rootPresentationMode, self.$isUser)
//    }
//}
//
//struct TestLoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        TestLoginView()
//            .environmentObject(ModelData())
//    }
//}
