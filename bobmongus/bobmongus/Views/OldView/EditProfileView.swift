
//
//  EditProfileView.swift
//  bobmongus
//
//  Created by Park Kangwook on 2022/04/06.
//
import SwiftUI
//
//class User: ObservableObject {
//    @Published var image = "mong1"
//    @Published var nickname = "Nickname"
//}

struct EditProfileView: View {
    
    @EnvironmentObject var modelData: ModelData
    
    @State var showModal = false
    @State var editNicknameModal = false
    //각 모달창들의 Bool값
    
    //    @ObservedObject var user = User()
    //    @State var userImage = ""
    
    var body: some View {
        
        ZStack{
            VStack {
                //                    VStack{
                //                        Text("프로필 변경")
                //                            .font(.custom("DungGeunMo", size: 40))
                //                    }
                
                Spacer()
                
                VStack{
                    Image(modelData.myProfile.icon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding()
                    //                        Text(modelData.myProfile.nickName)
                    //                            .font(.custom("DungGeunMo", size: 30))
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
                .padding(.bottom)
                
                VStack{
                    Button("프로필 사진 변경") {
                        //                            withAnimation {
                        //                                self.showModal.toggle()
                        showModal = true
                    }.font(.custom("DungGeunMo", size: 15))
                        .foregroundColor(.white)
                    
                }
                .frame(width: 135.0, height: 50.0)
                .background(RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color(red: 0.6352941176470588, green: 0.396078431372549, blue: 0.7372549019607844))
                    .shadow(color:.black, radius: 0, x:2 ,y: 3))
                .padding(.vertical)
                
                Button("닉네임 변경") {
                    editNicknameModal = true
                }
                .foregroundColor(.white)
                .frame(width: 135.0, height: 50.0)
                .background(RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(Color(red: 0.6352941176470588, green: 0.396078431372549, blue: 0.7372549019607844))
                    .shadow(color:.black, radius: 0, x:2 ,y: 3))
                .font(.custom("DungGeunMo", size: 15))
                
                Spacer()
            }
            .padding(.vertical)
            
            
            ZStack{
                if showModal {
                    Rectangle()
                        .foregroundColor(Color.black.opacity(0.6))
                        .frame(width: 500, height: 1000)
                        .edgesIgnoringSafeArea(.all)
                    //모달창 배경
                    ZStack{
                        RoundedRectangle(cornerRadius: 16)
                            .padding(.horizontal)
                            .frame(width: 350.0, height: 280.0)
                            .foregroundColor(Color.white)
                            .overlay(ModalContentView(showModal: self.$showModal)
                            )}
                    .transition(.move(edge: .bottom))
                }   //모달창 배경 끝
                
            }
            
            ZStack{
                if editNicknameModal {
                    Rectangle()
                        .foregroundColor(Color.black.opacity(0.6))
                        .frame(width: 500, height: 1000)
                        .edgesIgnoringSafeArea(.all)
                    //모달창 배경
                    ZStack{
                        RoundedRectangle(cornerRadius: 16)
                            .padding(.horizontal)
                            .frame(width: 390.0, height: 210.0)
                            .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.917))
                            .overlay(EditNicknameView(editNicknameModal: self.$editNicknameModal))
                    }
                    .transition(.move(edge: .bottom))
                }
            }
        }
        Spacer()
    }
}


struct ModalContentView: View {
    @EnvironmentObject var modelData: ModelData
    @Binding var showModal: Bool
    //    @ObservedObject var user = User()
    //    @ObservedObject var user: User
    
    //    @Binding var userImage: String
    
    var myIndex: Int {
        modelData.users.firstIndex {
            $0.id == modelData.myProfile.id
        }!
    }
    
    var body: some View {
        //        var profileImage = user.image
        
        VStack(alignment: .leading) {
            Spacer()
            
            Button(action: {
                withAnimation {
                    self.showModal.toggle()
                }
            }) {
                HStack {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.large)
                    Text("창 닫기")
                        .font(.custom("DungGeunMo", size: 17))
                }
            }
            .foregroundColor(/*@START_MENU_TOKEN@*/.purple/*@END_MENU_TOKEN@*/)
            
            VStack{
                HStack(alignment: .center){
                    Spacer()
                    Button(action: {
                        modelData.myProfile.icon = "bobmong"
                        modelData.users[myIndex].icon = "bobmong"
                        self.showModal.toggle()
                    }){Image("bobmong")}
                    Spacer()
                    Button(action: {
                        modelData.myProfile.icon = "usmong"
                        modelData.users[myIndex].icon = "usmong"
                        self.showModal.toggle()
                    }){Image("usmong")}
                    Spacer()
                    Button(action: {
                        modelData.myProfile.icon = "jjamong"
                        modelData.users[myIndex].icon = "jjamong"
                        self.showModal.toggle()
                    }){Image("jjamong")}
                    Spacer()
                }
                .padding(.top)
                HStack{
                    Spacer()
                    Button(action: {
                        modelData.myProfile.icon = "eggmong"
                        modelData.users[myIndex].icon = "eggmong"
                        self.showModal.toggle()
                    }){Image("eggmong")}
                    Spacer()
                    Button(action: {
                        modelData.myProfile.icon = "angelmong"
                        modelData.users[myIndex].icon = "angelmong"
                        self.showModal.toggle()
                    }){Image("angelmong")}
                    Spacer()
                    Button(action: {
                        modelData.myProfile.icon = "thugmong"
                        modelData.users[myIndex].icon = "thugmong"
                        self.showModal.toggle()
                    }){Image("thugmong")}
                    Spacer()
                }
                .padding(.bottom)
                
            }
            
            VStack(alignment: .center) {
                Button(action: {
                    withAnimation {
                        //self.showModal.toggle()
                    }
                }) {
                    HStack {
                        Image(systemName: "fork.knife")
                            .imageScale(.large)
                        Text("변경할 프로필 사진을 터치해주세요")
                            .fontWeight(.bold)
                            .font(.custom("DungGeunMo", size: 17))
                        
                    }
                    .padding(10.0)
                    //                    .background(
                    //                        RoundedRectangle(cornerRadius: 10)
                    //                            .stroke(lineWidth: 2)
                    //                    )
                }
                .foregroundColor(.purple)
                Spacer().frame(maxWidth:.infinity)
            }
        }.padding(30)
    }
}

struct EditNicknameView: View {
    
    @State private var editedNickname = ""
    @Binding var editNicknameModal: Bool
    @State private var nickNameAlert: Bool = false
    
    //    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var modelData: ModelData
    
    //    @ObservedObject var user = User()
    
    var myIndex: Int {
        modelData.users.firstIndex {
            $0.id == modelData.myProfile.id
        }!
    }
    
    var body: some View {
        //        var originNickname = user.nickname
        VStack(alignment: .leading) {
            Spacer()
            Button(action: {
                withAnimation {
                    self.editNicknameModal.toggle()
                }
            }) {
                HStack {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.large)
                    Text("창 닫기")
                        .font(.custom("DungGeunMo", size: 17))
                }
            }
            .foregroundColor(/*@START_MENU_TOKEN@*/.purple/*@END_MENU_TOKEN@*/)
            
            Text("변경하실 닉네임을 입력해주세요")
                .font(.custom("DungGeunMo", size: 17))
                .padding(.top)
            
            TextField("변경할 닉네임", text: $editedNickname)
                .modifier(ClearButton(text: $editedNickname))
                .disableAutocorrection(true) //MARK: 자동완성 없애주는 친구.
                .autocapitalization(.none)
                .textFieldStyle(.roundedBorder)
            //                .font(.custom("NEXON", size: 16))
                .padding(.bottom)
            
            
            //이버튼을 방 내부와 연결하면 될 듯
            //문제3 버튼 정렬만 센터로 따로 설정하는법 현재 VStack으로 왼쪽정렬로 고정함
            VStack(alignment: .center) {
                Button(action: {
                    withAnimation {
                        //self.showModal.toggle()
                    }
                }) {
                    HStack {
                        
                        let usersNickname = modelData.users.map { $0.nickName.lowercased() }
                        
                        Button("닉네임 변경") {
                            
                            if usersNickname.contains(editedNickname.lowercased()) {
                                
                                self.nickNameAlert = true
                                
                            } else {
                                modelData.myProfile.nickName = editedNickname
                                
                                modelData.users[myIndex].nickName = editedNickname
                                
                                self.editNicknameModal.toggle()
                            }
                            
                        }
                        .font(.custom("DungGeunMo", size: 17))
                        .alert(isPresented: $nickNameAlert) {
                            Alert(title: Text("알림"), message: Text("중복된 닉네임입니다."), dismissButton: .default(Text("닫기")))
                        }
                        //                        Image(systemName: "fork.knife")
                        //                            .imageScale(.large)
                        //                        Text("닉네임 변경")
                        //                            .fontWeight(.bold)
                        
                    }
                    .padding(10.0)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                    )
                }
                .foregroundColor(.purple)
                Spacer().frame(maxWidth:.infinity)
            }
        }.padding(30)
    }
}


struct EditPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
            .environmentObject(ModelData())
    }
}
