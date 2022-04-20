//
//  TestRoomMakingView.swift
//  Tamongus
//
//  Created by Hyeonsoo Kim on 2022/04/11.
//

import SwiftUI

struct TestRoomMakingView: View {
    @EnvironmentObject var modelData: ModelData
    
    @Binding var showModal: Bool
    @Binding var isMake: Bool
    @Binding var newRoom: Room
    
    @State var persons = 2
    @State var roomTime = Date()
    @State var roomTimeString = ""
    
    @State var roomTitle: String = ""
    @State var roomDetail: String = ""
    @State var linkURL: String = ""
    
    @State var endTime = 5
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Spacer()
            
            Button {
                
                withAnimation {
                    self.showModal.toggle()
                }
                
            } label: {
                
                HStack {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.medium)
                        .foregroundColor(.red)
                    
                    Text("창 닫기")
                        .font(.custom("DungGeunMo", size: 17))
                }
                .foregroundColor(.black)
            }
            .padding(.vertical, 10.0)
            
            TextField("방 제목", text: $roomTitle)
                .modifier(ClearButton(text: $roomTitle))
                .disableAutocorrection(true) //MARK: 자동완성 없애주는 친구.
                .autocapitalization(.none)
                .textFieldStyle(.roundedBorder)
            
            TextField("세부 설명 (만남 위치, 배달비 등등)", text: $roomDetail)
                .modifier(ClearButton(text: $roomDetail))
                .disableAutocorrection(true) //MARK: 자동완성 없애주는 친구.
                .autocapitalization(.none)
                .textFieldStyle(.roundedBorder)
            
            TextField("카카오톡 오픈채팅 주소", text: $linkURL)
                .modifier(ClearButton(text: $linkURL))
                .disableAutocorrection(true) //MARK: 자동완성 없애주는 친구.
                .autocapitalization(.none)
                .textFieldStyle(.roundedBorder)
            
            Stepper(value: $persons, in: 2...6) {
                
                Image(systemName: "person.fill")
                
                Text("\(persons)명(본인포함)")
                    .font(.custom("DungGeunMo", size: 17))
                
            }
            .padding(.top, 10.0)
            
            Stepper(value: $endTime, in: 5...90, step: 5) {
                Image(systemName: "timer")
                Text("마감시간 \(endTime)분")
                    .font(.custom("DungGeunMo", size: 17))
            }
            
            //            let min = Date()
            //            let max = Calendar.current.date(byAdding: .hour, value: 48, to: Date())! //MAKR: 여기서 max조절가능.
//
//
//
//            DatePicker(selection: $endTime, in: min..., displayedComponents: .hourAndMinute , label: {
//
//                Image(systemName: "timer")
//                Text("마감시간설정")
//                    .font(.custom("DungGeunMo", size: 17))
//
//            })
            
            VStack {
                
                Button {
                    
                    modelData.myProfile.isMakingRoom = true
                    
                    let uuid = UUID()
                    
                    let room: Room = Room(id: uuid, isStart: false, roomTitle: roomTitle, roomDetail: roomDetail, nowPersons: [], persons: persons, endTime: endTime, linkURL: linkURL, roomTimeStr: roomTime.formatted(date: .omitted, time: .standard))
                    
                    modelData.rooms.append(room)
                    
//                    modelData.rooms = modelData.rooms.sorted(by: { //MARK: append할 때, sorted. Nice.
//                        if $0.isStart == false && $1.isStart == false {
//                            return timeCal(room: $0) < timeCal(room: $1)
//                        } else {
//                            return !$0.isStart  //MARK: !!!
//                        }
//                    })
                    
                    self.showModal.toggle()
                    
                    self.newRoom = room
                    
                    self.isMake.toggle()
                    
                } label: {
                    
                    HStack {
                        
                        Image(systemName: "fork.knife")
                            .imageScale(.medium)
                        
                        Text("방 만들기")
                            .font(.custom("DungGeunMo", size: 20))
                        
                    }
                    .padding(10.0)
                    .background(
                        
                        RoundedRectangle(cornerRadius: 10)
                            .shadow(color:.black, radius: 0, x:2 ,y: 3)
                            .foregroundColor(Color(red: 0.982, green: 0.71, blue: 0.629))
                        
                    )
                }
                .foregroundColor(.white)
                
                Spacer().frame(maxWidth:.infinity)
            }
            .padding(.top, 5.0)
        }
        .padding(.horizontal, 20)
    }
}
