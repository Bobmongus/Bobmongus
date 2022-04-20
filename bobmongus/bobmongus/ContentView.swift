//
//  ContentView.swift
//  bobmongus
//
//  Created by ryu hyunsun on 2022/04/06.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        EntranceView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}


/*
 rooms
 
 myProfile
 
 users
 
 myProfile은 처음 회원가입하기 전에는 없어야하는데 음...
 회원가입 값을 받고 users에 추가.
 
 로그인 시에 users 목록에 그 아이디, 비번과 같은 사람이 있으면,
 그 user index의 user값을 myProfile에 할당.
 
 그러고 메인화면 시작.
 
 user 정보는 userDefaults를 저장.
 */
