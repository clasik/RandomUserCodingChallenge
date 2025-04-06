import Combine
import SwiftData
import Foundation
@testable import RandomUserCodingChallenge

struct SwiftDataServiceMock: SwiftDataBaseService {
    
    private let randonUserMockList: [RandomUser]
    
    init(randonUserMockList: [RandomUser] = []) {
        self.randonUserMockList = randonUserMockList
    }
    
    func fetchRandomUser() -> [RandomUser] {
        randonUserMockList
    }
    
    func insertRandomUsers(_ randomUsers: [RandomUser]) {}
    
    func hideUser(_ user: RandomUser) {
        user.isHidden = true
    }
    
}
