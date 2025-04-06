import Foundation
import SwiftData

struct RandomUserResponse: Codable {
    struct APIUser: Codable {
        struct Name: Codable {
            let first: String?
            let last: String?
        }
        struct Location: Codable {
            struct Street: Codable {
                let name: String?
                let number: Int?
            }
            let street: Street?
            let city: String?
            let state: String?
        }
        struct Picture: Codable {
            let large: String?
        }
        struct Registered: Codable {
            let date: String?
        }
        let gender: String?
        let name: Name?
        let location: Location?
        let email: String?
        let phone: String?
        let registered: Registered?
        let picture: Picture?
    }
    let results: [APIUser]
}

@Model
class RandomUser: Equatable {
    var addedDate: Date
    @Attribute(.unique) var email: String?
    var gender: String?
    var name: String?
    var location: String?
    var phone: String?
    var registeredDate: String?
    var pictureURL: String?
    var isHidden: Bool
    
    init(addedDate: Date = Date(), gender: String?, name: String?, email: String?, location: String?, phone: String?, registeredDate: String?, pictureURL: String?, isHidden: Bool = false) {
        self.addedDate = addedDate
        self.gender = gender
        self.name = name
        self.email = email
        self.location = location
        self.phone = phone
        self.registeredDate = registeredDate
        self.pictureURL = pictureURL
        self.isHidden = isHidden
    }
    
    var description: String {
        "\(name ?? "") \(email ?? "")"
    }
    
    static func == (lhs: RandomUser, rhs: RandomUser) -> Bool {
        lhs.email == rhs.email
    }
}
