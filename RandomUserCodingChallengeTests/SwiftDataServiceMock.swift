import Combine
import SwiftData
import Foundation
@testable import RandomUserCodingChallenge

struct SwiftDataServiceMock: SwiftDataBaseService {
    
    private let randomUserMockList: [RandomUser]
    
    init(randomUserMockList: [RandomUser] = []) {
        self.randomUserMockList = randomUserMockList
    }
    
    func fetchRandomUser() -> [RandomUser] {
        randomUserMockList
    }
    
    func insertRandomUsers(_ randomUsers: [RandomUser]) {}
    
    func hideUser(_ user: RandomUser) {
        user.isHidden = true
    }
    
}
