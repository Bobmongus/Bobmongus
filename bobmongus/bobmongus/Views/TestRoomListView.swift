//
//  TestRoomListView.swift
//  Tamongus
//
//  Created by Hyeonsoo Kim on 2022/04/11.
//

import SwiftUI

struct TestRoomListView: View {
    @EnvironmentObject var modelData: ModelData
    
    @State var showModal: Bool = false
    @State var isMake: Bool = false
    @State var newRoom: Room = Room(id: UUID(), isStart: false, roomTitle: "title", roomDetail: "detail", nowPersons: [], persons: 100, endTime: 100, linkURL: "linkURL")
    
    var body: some View {
        
        let height = (UIScreen.main.bounds.height) / 11
        
        NavigationView {
            
            ZStack {
                
                VStack {
                    
                    HStack { // 상단 설명 아이콘 영역
                        VStack {
                            Image("people")
                                .resizable().frame(width: 46, height: 46)
                                .padding(.leading, 20)
                        }
                        Spacer()
                        Image("logo")
                            .resizable().frame(width: 200, height: 30)
                        Spacer()
                        Image("boob")
                            .resizable().frame(width: 48, height: 46)
                            .padding(.trailing, 20)
                    }
                    
                    ScrollView {
                        
                        VStack {
                            
                            if modelData.rooms.count != 0 {
                                
                                ForEach(0...modelData.rooms.count-1, id: \.self) { index in
                                    
                                    NavigationLink {
                                        
                                        TestRoomView(room: $modelData.rooms[index])
                                            .navigationBarTitleDisplayMode(.inline)
                                        
                                    } label: {
                                        
                                        TestRoomCell(room: modelData.rooms[index])
                                            .frame(height: height)
                                        
                                    }
                                }
                                
                                
                                NavigationLink(isActive: $isMake) {
                                    
                                    TestRoomView(room: $newRoom)
                                        .navigationBarTitleDisplayMode(.inline)
                                    
                                } label: {
                                    
                                    EmptyView()
                                }
                            }
                        }
                    }
                    .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .black, .clear]), startPoint: .center, endPoint: .bottom))
                    
                    HStack {    // 하단부 버튼 영역
                        NavigationLink { // 마이페이지
                            MypageView().navigationTitle("마이페이지").navigationBarTitleDisplayMode(.inline)
                        } label: {
                                Image(systemName: "person.fill")
                                    .frame(width:46, height:46)
                                    .foregroundColor(.white)
                                    .background(.purple)
                                    .font(.largeTitle)
                                    .cornerRadius(6)
                                    .shadow(color: .primary, radius: 1, x: 2, y: 2)
                                    .padding(.top, 5)
                        }
                        .isDetailLink(false)
                        .padding(.leading, 40)
                        Spacer()
                        
                        Button {
                            withAnimation {
                                
                                self.showModal.toggle()
                                
                            }
                        } label: {
                            
                            Text("방만들기")
                                .frame(width:140, height:45)
                                .foregroundColor(.white)
                                .background(.purple)
                                .font(.custom("DungGeunMo", size: 32))
                                .cornerRadius(6)
                                .shadow(color: .primary, radius: 1, x: 2, y: 2)
                                .padding(.top, 5)
                            
                        }
                        
                        Spacer()
                        
                        Button {
                            print()
                        } label: {
                            Image(systemName: "arrow.counterclockwise")
                                .padding(40)
                                .frame(width:45, height:45)
                                .foregroundColor(.white)
                                .background(.purple)
                                .font(.largeTitle)
                                .cornerRadius(6)
                                .shadow(color: .primary, radius: 1, x: 2, y: 2)
                                .padding(.top, 5)
                            
                        }
                        .padding(.trailing, 40)
                    }
                }   // VStack end
                .navigationBarHidden(true)
                .background(
                    Image("mainBackground")
                        .resizable()
                        .edgesIgnoringSafeArea(.all)
                )
                
                if showModal {
                    
                    Rectangle()
                        .foregroundColor(Color.black.opacity(0.6))
                        .edgesIgnoringSafeArea(.all)
                    
                    ZStack {
                        
                        let width = UIScreen.main.bounds.width
                        
                        RoundedRectangle(cornerRadius: 16)
                            .padding(.horizontal)
                            .frame(width: width, height: width / 13 * 11) //aspect
                            .foregroundColor(Color(hue: 1.0, saturation: 0.0, brightness: 0.917))
                            .overlay {
                                TestRoomMakingView(showModal: $showModal, isMake: $isMake, newRoom: $newRoom)
                                
                            }
                    }
                    .transition(.move(edge: .bottom))
                }
            }
            .onAppear {
                modelData.myProfile.isReady = false
                modelData.myProfile.isMakingRoom = false
            }
        }
    }
}

struct TestRoomCell: View {
    
    @State var room: Room
    
    var body: some View {
        
        ZStack {
            
            RoomCellShape()
                .foregroundColor(.white)
            
            HStack {
                
                Text("\(room.nowPersons.count)/\(room.persons)")
                    .font(.custom("DungGeunMo", size: 20))
                                        .frame(width: 40)
                
                Rectangle() // Devider
                                    .fill(Color.black)
                                    .frame(width: 2, height: 40)
                Spacer()
                
                Text(room.roomTitle)
                    .font(.custom("DungGeunMo", size: 20))
                
                Spacer()
                Rectangle() // Devider
                                    .fill(Color.black)
                                    .frame(width: 2, height: 40)
                
                Text("\(room.endTime)분")
                    .font(.custom("DungGeunMo", size: 20))
                                        .frame(width: 40)
                
            }
            .foregroundColor(.black)
            .padding()
            
        }
        .padding(.horizontal, 6)
    }
}

struct TestRoomListView_Previews: PreviewProvider {
    static var previews: some View {
        TestRoomListView(newRoom: ModelData().rooms[0])
            .environmentObject(ModelData())
    }
}
