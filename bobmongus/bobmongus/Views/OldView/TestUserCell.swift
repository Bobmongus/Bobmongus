//
//  TestUserCell.swift
//  Tamongus
//
//  Created by Hyeonsoo Kim on 2022/04/11.
//

import SwiftUI

struct TestUserCell: View {
    
    @State var scale: CGFloat = 1.0
    @State var rotation: Double = 0.0
    
    @Binding var room: Room
    @Binding var user: Room.User
    
    var body: some View {
        
        let width = UIScreen.main.bounds.width / 4
        let height = UIScreen.main.bounds.width / 3
        
        ZStack {
            
            VStack {
                
                if room.isStart {
                    
                    Text(user.nickName)
                        .font(.custom("NEXON", size: 17))
                    
                } else {
                    
                    Text("익명")
                        .font(.custom("NEXON", size: 17))
                    
                }
                
                Text(user.userAddress)
                    .font(.custom("NEXON", size: 12))
                
                Image(user.icon)
                    .resizable()
                    .scaleEffect(user.isReady ? 1.2 : 1, anchor: .center)
                    .rotationEffect(.degrees(room.isStart ?
                                             rotation + 360 : rotation))
                    .animation(.spring(response: 0.2,
                                       dampingFraction: 0.05,
                                       blendDuration: 0),
                               value: user.isReady ?
                               1.2 : 1.0)
                    .animation(.spring(response: 0.2,
                                       dampingFraction: 0.05,
                                       blendDuration: 0),
                               value: room.isStart ?
                               rotation + 360 : rotation)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width/3 * 2, height: width/3 * 2)
                    .shadow(color: .white,
                            radius: user.isReady ? 10 : 0,
                            x: 0, y: 0)
                
                if room.isStart {
                    
                    Text("START")
                        .font(.custom("DungGeunMo", size: 28))
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                    
                } else {
                    
                    Text("READY")
                        .font(.custom("DungGeunMo", size: 28))
                        .fontWeight(.bold)
                        .foregroundColor(
                            user.isReady ? .red : .gray.opacity(0.3)
                        )
                }
            }
            .frame(width: width,
                   height: height)
            
            user.isMakingRoom ?
            Image(systemName: "star.fill").foregroundColor(.yellow).shadow(color: .black, radius: 5, x: 2, y: 2)
                .offset(x: -width/3, y: -width/4)
            :
            Image(systemName: "star").foregroundColor(.clear).shadow(color: .black, radius: 0, x: 2, y: 2)
                .offset(x: -width/3, y: -width/4)
           
        }
    }
}

struct TestUserCell_Previews: PreviewProvider {
    static var previews: some View {
        TestUserCell(
            room: .constant(ModelData().rooms[0]),
            user: .constant(ModelData().rooms[0].nowPersons[0]))
            .environmentObject(ModelData())
    }
}
