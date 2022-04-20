//
//  MypageView.swift
//  bobmongus
//
//  Created by Park Kangwook on 2022/04/06.
//
import SwiftUI

struct MypageView: View {
    
    @EnvironmentObject var modelData: ModelData
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    
    @State private var showingAlert = false
    //기존 프로필 이미지 편의상 mong1로 설정
    //이미지파일 이름 통일시켜야 함
    
    //    @State private var nickname = "Nickname"
    //기존 유저 닉네임 편의상 Nickname으로 설정
    
    var myIndex: Int {
        modelData.users.firstIndex {
            $0.id == modelData.myProfile.id
        }!
    }
    
    var body: some View {
//        VStack {
//            Text("My Page")
//                .padding(.bottom)
//                .font(.custom("DungGeunMo", size: 60))
//                .font(.headline)
            
            VStack {
                VStack {
                    Spacer()
                    Image(modelData.myProfile.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding()
                    Text(modelData.myProfile.nickName)
                        .fontWeight(.heavy)
//                        .padding(.vertical)
                        .font(.custom("NEXON Lv2 Gothic OTF", size: 30))
                        .padding(.bottom)
                    Text(modelData.myProfile.email)
                        .fontWeight(.medium)
                        .padding(.bottom)
                        .font(.custom("NEXON Lv2 Gothic OTF", size: 15))
                        .foregroundColor(.gray)
                }
                
                VStack {
                    NavigationLink(destination:EditProfileView()
                        .navigationTitle("프로필 변경").navigationBarTitleDisplayMode(.inline))
                            {
                            Text("프로필 변경")
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: 135, height: 50)
                                .font(.custom("DungGeunMo", size: 17))
                                
                        }
                        .background(RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(red: 0.6352941176470588, green: 0.396078431372549, blue: 0.7372549019607844))
                        .shadow(color:.black, radius: 0, x:2 ,y: 3))
                    
                    NavigationLink(destination:EditPasswordView()
                        .navigationTitle("비밀번호 변경").navigationBarTitleDisplayMode(.inline)) {
                            Text("비밀번호 변경")
                                .foregroundColor(.white)
                                .bold()
                                .frame(width: 135, height: 50)
                                .font(.custom("DungGeunMo", size: 17))
                                
                        }
                        .background(RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(Color(red: 0.6352941176470588, green: 0.396078431372549, blue: 0.7372549019607844))
                        .shadow(color:.black, radius: 0, x:2 ,y: 3)
                        )
                        .padding(.vertical)
                    
                    Button("로그아웃") {
                        modelData.myProfile.isLogin = false
                        //MARK: pop to root
                        self.rootPresentationMode.wrappedValue.dismiss()
                    }
                    .font(.custom("DungGeunMo", size: 17))
                    .background(RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color(red: 0.937, green: 0.937, blue: 0.942))
                    .frame(width: 135.0, height: 50.0)
                    .shadow(color:.black, radius: 0, x:2 ,y: 3))
                    .foregroundColor(.black)
//                    .frame(width: 135.0, height: 50.0)
                    
//                    .background(Color(red: 0.937, green: 0.937, blue: 0.942).shadow(color:.black, radius: 0, x:2 ,y: 3)
                    
//                    .cornerRadius(10)
                    .padding(.vertical)
                    
                    Spacer()
                    HStack {
                        Spacer()
                        Button("탈퇴") {
                            self.showingAlert = true
                        }
                        .font(.custom("DungGeunMo", size: 17))
                        .padding()
//                        .background(RoundedRectangle(cornerRadius: 10)
//                        .foregroundColor(Color(red: 0.937, green: 0.937, blue: 0.942))
//                        .frame(width: 135.0, height: 50.0)
//                        .shadow(color:.black, radius: 0, x:2 ,y: 3))
                        .foregroundColor(.red)

                    }.padding(.vertical)
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("회원 탈퇴"), message: Text("정말 탈퇴하시겠습니까?"),
                              primaryButton:
                                .destructive(Text("탈퇴"), action: {
                                    // Some action
                                    // json 파일에서 회원 정보 삭제
                                    modelData.users.remove(at: myIndex)
                                    modelData.myProfile.isLogin = false //users에서 삭제된것이지 myProfile이 삭제된 상태가 아님. 하지만 이젠 기존 정보론 로그인을 못함.
                        
                                    self.rootPresentationMode.wrappedValue.dismiss()
                                }),
                              secondaryButton:
                                .default(Text("아니오"))
                        )
                    }
//                    .frame(width: 135.0, height: 50.0)
//                    .background(Color(red: 0.937, green: 0.937, blue: 0.942))
//                    .shadow(color:.black, radius: 0, x:2 ,y: 3)
//                    .foregroundColor(.red)
//                    .cornerRadius(10)
                    
                }
            }
        }
    }
    
//}

struct MypageView_Previews: PreviewProvider {
    static var previews: some View {
        MypageView()
            .environmentObject(ModelData())
    }
}
