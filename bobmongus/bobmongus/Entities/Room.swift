
 //
//  Room.swift
//  bobmongus
//
//  Created by Hyeonsoo Kim on 2022/04/10.

import SwiftUI

struct Room: Codable, Identifiable {
    var id: UUID
    var isStart: Bool
    var roomTitle: String
    var roomDetail: String
    var nowPersons: [User]
    var persons: Int
    var endTime: Int
    var linkURL: String
    var roomTimeStr: String
    
    struct User: Codable, Identifiable {
        var id: UUID
        var email: String
        var password: String
        var icon: String
        var isLogin: Bool
        var isReady: Bool
        var isMakingRoom: Bool
        var nickName: String
        var userAddress: String
    }
}
