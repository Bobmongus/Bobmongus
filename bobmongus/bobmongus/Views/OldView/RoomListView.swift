//
//  TestRoomListView.swift
//  Tamongus
//
//  Created by Hyeonsoo Kim on 2022/04/11.
//
import SwiftUI

struct RoomListView: View {
    @EnvironmentObject var modelData: ModelData
    
    @State var showModal: Bool = false
    @State var isMake: Bool = false
    @State var newRoom: Room = Room(id: UUID(), isStart: false, roomTitle: "title", roomDetail: "detail", nowPersons: [], persons: 100, endTime: 100, linkURL: "linkURL", roomTimeStr: "10:51:00 AM")
    
    
    var body: some View {
       
        let height = (UIScreen.main.bounds.height) / 11
        
        
        NavigationView {
            
            ZStack {
                
                VStack {
                    
                    Image("logo")
                    
                    ZStack {
                        
                        Image("rectangle")
                        
                        HStack {
                            Text("인원수")
                            
                            Spacer()
                            
                            Text("방제목")
                            
                            Spacer()
                            
                            Text("남은시간")
                            
                        }.padding(.horizontal, 30)
                            .foregroundColor(.white)
                            .font(.custom("NEXON", size: 15))
                            
                            
                    
                    }
                    
                    ScrollView {
                        
                        VStack {
                            
                            ForEach(0..<modelData.rooms.count, id: \.self) { index in
                                
                                NavigationLink {
                                    
                                    TestRoomView(room: $modelData.rooms[index])
                                        .navigationBarTitleDisplayMode(.inline)
                                    
                                } label: {
                                    RoomCell(room: modelData.rooms[index])
                                        .frame(height: height)  // 각 방의 세로 길이
                                    
                                }
                            }
                            
                            NavigationLink(isActive: $isMake) {
                                
                                TestRoomView(room: $newRoom)
                                    .navigationBarTitleDisplayMode(.inline)
                                
                            } label: {
                                
                                EmptyView()
                            }
                        }   // VStack(Rooms) end
                    }   // ScrollView end
                    // 하단부에 사라지는 효과를 위해 mask 사용
                    .mask(LinearGradient(gradient: Gradient(colors: [.black, .black, .black, .clear]), startPoint: .center, endPoint: .bottom))
                    
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color(red: 0.982, green: 0.71, blue: 0.629).opacity(0))
                            .edgesIgnoringSafeArea(.all)
                            .frame(height: 60)
                            
                        HStack {    // 하단부 버튼 영역
                            NavigationLink( // 마이페이지
                                destination: MypageView(),
                                label: {
                                    Image("mypage")
                                        .padding(40)
                                        .frame(width:45, height:45)
                                        .foregroundColor(.white)
                                        .font(.largeTitle)
                                        .padding(.top, 5)
                                }
                            )
                            .isDetailLink(false)
                            .padding(.leading, 40)
                            Spacer()
                            
                            Button {
                                withAnimation {
                                    
                                    self.showModal.toggle()
                                    
                                }
                            } label: {
                                
                                HStack {
                                    
                                    Text("방만들기")
                                        .frame(width:140, height:45)
                                        .foregroundColor(.white)
                                        .background(Color(red: 0.6352941176470588, green: 0.396078431372549, blue: 0.7372549019607844))
                                        .font(.custom("DungGeunMo", size: 20))
                                        .cornerRadius(6)
                                        .shadow(color: .primary, radius: 1, x: 2, y: 2)
                                        .padding(.top, 5)
                                    
                                }
                            }
                            
                            Spacer()

                            Button {
                                print()
                            } label: {
                                Image("refresh")
                                    .frame(width:45, height:45)
                                    .padding(.top, 5)
                                    
                            }
                            .padding(.trailing, 40)
                        }
                    }   // HStack end
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

struct RoomCell: View {
    
    @State var room: Room
    
    var body: some View {
        
        ZStack {
            
            Image("rect")
            
            HStack {
                
                Text("\(room.nowPersons.count)명/\(room.persons)명") // 인원수
                    .font(.custom("NEXON", size: 12))
                    .frame(width: 50)
                

                Spacer()
                
                Text(room.roomTitle) // 방 타이틀
                    .font(.custom("DungGeunMo", size: 17))
                
                Spacer()
                
                Text("\(timeCal(room:room))분 남음") // 방 남은시간
                    .font(.custom("NEXON", size: 12))
                    .frame(width: 50)
            }
            .foregroundColor(.black)    // 방 내부 글자색
            .padding()
        }
        .padding(.horizontal, 6)        // 방 양으로 패딩
    }
}

struct RoomListView_Previews: PreviewProvider {
    static var previews: some View {
        RoomListView(newRoom: ModelData().rooms[0])
            .environmentObject(ModelData())
    }
}


// MARK: [24 시간 형태 현재 날짜 확인]
func getNowDateTime24() -> String {
    // [date 객체 사용해 현재 날짜 및 시간 24시간 형태 출력 실시]
    let nowDate = Date() // 현재의 Date 날짜 및 시간
    let dateFormatter = DateFormatter() // Date 포맷 객체 선언
    dateFormatter.locale = Locale(identifier: "ko") // 한국 지정
    dateFormatter.dateFormat = "kk:mm:ss" // Date 포맷 타입 지정
    let date_string = dateFormatter.string(from: nowDate) // 포맷된 형식 문자열로 반환
    return date_string
}

func timeCal(room: Room) -> Int {
    let nowTime = getNowDateTime24().components(separatedBy: ":")
    let roomTimeArr = room.roomTimeStr.components(separatedBy: " ")
    let tempTimeArr = roomTimeArr[0].components(separatedBy: ":")
    var timeArr = [0,0,0]
    var nowArr = [0,0,0]
    for x in 0..<3 {
        if tempTimeArr[x] == "00" {
            timeArr[x] = 0
        } else {
            timeArr[x] = Int(tempTimeArr[x])!
        }
    }
    if roomTimeArr[1] == "PM" {
        timeArr[0] += 12
    }
    for x in 0..<3 {
        if nowTime[x] == "00" {
            nowArr[x] = 0
        } else {
            nowArr[x] = Int(nowTime[x])!
        }
    }
    
    let nowMinute = nowArr[0]*60 + nowArr[1]
    let roomMinute = timeArr[0]*60 + timeArr[1]
    
    // endtime - 현재시간 + 생성시간 - 24시간
    var answer = room.endTime - nowMinute + roomMinute
    if answer < 0 {
        answer += 1440
    }
    
    return answer
}
