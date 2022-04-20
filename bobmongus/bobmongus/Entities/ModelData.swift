



import SwiftUI
import Combine

final class ModelData: ObservableObject {
    
    @Published var users: [Room.User] {
        didSet {
            UserDefaults.standard.set(encodeToJJson(users), forKey: "users")
        }
    }
    
    @Published var rooms: [Room] {
        didSet {
            UserDefaults.standard.set(encodeToJJJson(rooms), forKey: "rooms")
        }
    }
    
    @Published var myProfile: Room.User {
        didSet {
            UserDefaults.standard.set(encodeToJson(myProfile), forKey: "myProfile")
        }
    }
    
    
    
    init() { //마지막에 저장된 값으로 초기화됨. 앱 시동 후 불러와질 때?!
        self.myProfile = decodeToUser(UserDefaults.standard.data(forKey: "myProfile") ??
                                      encodeToJson(Room.User(id: UUID(), email: "email@pos.idserve.net", password: "password", icon: "bobmong", isLogin: false, isReady: false, isMakingRoom: false, nickName: "nickName", userAddress: "userAddress"))
        )
        
        self.users = decodeToUsers(UserDefaults.standard.data(forKey: "users") ?? encodeToJJson(userArr))
        
        self.rooms = decodeToUserss(UserDefaults.standard.data(forKey: "rooms") ?? encodeToJJJson(testRooms.sorted(by: {
            timeCal(room: $0) < timeCal(room: $1)
        })))
    }    
}

var userArr: [Room.User] = loadJson("dummyusers.json")

var testRooms: [Room] = loadJson("dummyrooms.json")

func loadJson<T: Decodable>(_ filename: String) -> T {
    
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("\(filename) not found.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Could not load \(filename): \(error)")
    }
    
    do {
        return try JSONDecoder().decode(T.self, from: data)
    } catch {
        fatalError("Unable to parse \(filename): \(error)")
    }
}


func encodeToJson(_ user: Room.User) -> Data {
    do {
        return try JSONEncoder().encode(user.self)
    } catch {
        fatalError("Unable to encode")
    }
}

func decodeToUser(_ data: Data) -> Room.User {
    do {
        return try JSONDecoder().decode(Room.User.self, from: data)
    } catch {
        fatalError("Unable to decode")
    }
}

func encodeToJJson(_ user: [Room.User]) -> Data {
    do {
        return try JSONEncoder().encode(user.self)
    } catch {
        fatalError("Unable to encode")
    }
}

func decodeToUsers(_ data: Data) -> [Room.User] {
    do {
        return try JSONDecoder().decode([Room.User].self, from: data)
    } catch {
        fatalError("Unable to decode")
    }
}

func encodeToJJJson(_ user: [Room]) -> Data {
    do {
        return try JSONEncoder().encode(user.self)
    } catch {
        fatalError("Unable to encode")
    }
}

func decodeToUserss(_ data: Data) -> [Room] {
    do {
        return try JSONDecoder().decode([Room].self, from: data)
    } catch {
        fatalError("Unable to decode")
    }
}
