import Testing
import SwiftData
import Foundation
import Combine
@testable import RandomUserCodingChallenge

struct RandomUserListViewModelTests {
    
    @Test func testAppStartsEmpty() throws {
        let swiftDataService = SwiftDataServiceMock()
        let sut = RandomUserListViewModel(swiftDataService: swiftDataService)
        #expect(sut.randomUsers.isEmpty, "The list is empty initially")
    }
    
    @Test func testFetchSwiftDataWorks() throws {
        let swiftDataService = SwiftDataServiceMock(randomUserMockList: RandomUserMock.randomUsers)
        let sut = RandomUserListViewModel(swiftDataService: swiftDataService)
        
        #expect(sut.randomUsers.count == RandomUserMock.randomUsers.filter{ !$0.isHidden }.count, "The list fetched from SwiftData should have the same number of users that the mock")
    }
    
    @MainActor
    @Test func testFetchMoreDataWorks() async throws {
        let swiftDataService = SwiftDataServiceMock()
        let randomUserService = RandomUserService(httpService: HttpServiceMock())
        let sut = RandomUserListViewModel(swiftDataService: swiftDataService, randomUserService: randomUserService)
        _ = await sut.$randomUsers.values.first()
        
        #expect(sut.randomUsers.count == RandomUserMock.apiRandomUsers.count, "The list fetched from RandomUserService should have the same number of users that the mock")
    }
    
    @MainActor
    @Test func testIgnoreDuplicatedUsersWorks() async throws {
        let swiftDataService = SwiftDataServiceMock()
        let randomUserService = RandomUserService(httpService: HttpServiceMock())
        let sut = RandomUserListViewModel(swiftDataService: swiftDataService, randomUserService: randomUserService)
        _ = await sut.$randomUsers.values.first()
        sut.fetchMoreData()
        _ = await sut.$randomUsers.values.first()
        
        #expect(sut.randomUsers.count == RandomUserMock.apiRandomUsers.count, "The list fetched from RandomUserService should have the same number of users that the mock not the double")
    }
    
    @Test func testDeleteWorks() throws {
        let swiftDataService = SwiftDataServiceMock(randomUserMockList: RandomUserMock.randomUsers)
        let sut = RandomUserListViewModel(swiftDataService: swiftDataService)
        let index = sut.randomUsers.firstIndex(of: RandomUserMock.randomUsers[2])
        sut.delete(at: IndexSet([index!]))
        sut.filterHiddenUsers(false)
        
        #expect(sut.randomUsers.count == RandomUserMock.randomUsers.filter{ !$0.isHidden }.count, "The list fetched should have one less user that the mock")
    }
    
    @MainActor
    @Test func testFetchSearchResultsWorks() throws {
        let swiftDataService = SwiftDataServiceMock(randomUserMockList: RandomUserMock.randomUsers)
        let randomUserService = RandomUserService(httpService: HttpServiceMock())
        let sut = RandomUserListViewModel(swiftDataService: swiftDataService, randomUserService: randomUserService)
        sut.fetchSearchResults(for: RandomUserMock.randomUsers[2].name!)
        
        #expect(sut.randomUsers.count == 1, "The list should have one user that the mock")
    }
}

extension AsyncSequence {
    func first() async rethrows -> Element? {
        try await first(where: { _ in true})
    }
}
