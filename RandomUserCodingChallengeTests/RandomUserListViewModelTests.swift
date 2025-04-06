import Testing
import SwiftData
import Foundation
import Combine
@testable import RandomUserCodingChallenge

struct RandomUserListViewModelTests {
    
    @MainActor
    @Test func testAppStartsEmpty() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: RandomUser.self, configurations: config)
        let sut = RandomUserListViewModel(modelContext: container.mainContext)
        
        #expect(sut.randomUsers.count == 0, "The list is empty initially")
    }
    
    @MainActor
    @Test func testFetchSwiftDataWorks() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: RandomUser.self, configurations: config)
        addRandomUserFakeData(modelContext: container.mainContext)
        let sut = RandomUserListViewModel(modelContext: container.mainContext)
        
        #expect(sut.randomUsers.count == RandomUserMock.randomUsers.filter{ !$0.isHidden }.count, "The list fetched from SwiftData should have the same number of users that the mock")
    }
    
    
    @MainActor
    @Test func testFetchMoreDataWorks() async throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: RandomUser.self, configurations: config)
        let sut = RandomUserListViewModel(modelContext: container.mainContext, randomUserService: RandomUserService(httpService: HttpServiceMock()))
        _ = await sut.$randomUsers.values.first()
        
        #expect(sut.randomUsers.count == RandomUserMock.apiRandomUsers.count, "The list fetched from RandomUserService should have the same number of users that the mock")
    }
    
    @MainActor
    @Test func testIgnoreDuplicatedUsersWorks() async throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: RandomUser.self, configurations: config)
        let sut = RandomUserListViewModel(modelContext: container.mainContext, randomUserService: RandomUserService(httpService: HttpServiceMock()))
        _ = await sut.$randomUsers.values.first()
        sut.fetchMoreData()
        _ = await sut.$randomUsers.values.first()
        
        #expect(sut.randomUsers.count == RandomUserMock.apiRandomUsers.count, "The list fetched from RandomUserService should have the same number of users that the mock not the double")
    }
    
    @MainActor
    @Test func testDeleteWorks() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: RandomUser.self, configurations: config)
        addRandomUserFakeData(modelContext: container.mainContext)
        let sut = RandomUserListViewModel(modelContext: container.mainContext)
        let index = sut.randomUsers.firstIndex(of: RandomUserMock.randomUsers[2])
        sut.delete(at: IndexSet([index!]))
        sut.filterHiddenUsers(false)
        
        #expect(sut.randomUsers.count == RandomUserMock.randomUsers.filter{ !$0.isHidden }.count, "The list fetched should have one less user that the mock")
    }
    
    @MainActor
    @Test func testFetchSearchResultsWorks() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: RandomUser.self, configurations: config)
        addRandomUserFakeData(modelContext: container.mainContext)
        let sut = RandomUserListViewModel(modelContext: container.mainContext)
        sut.fetchSearchResults(for: RandomUserMock.randomUsers[2].name!)
        
        #expect(sut.randomUsers.count == 1, "The list should have one user that the mock")
    }
    
    
    func addRandomUserFakeData(modelContext: ModelContext) {
        RandomUserMock.randomUsers.forEach {
            modelContext.insert($0)
        }
    }
}

extension AsyncSequence {
    func first() async rethrows -> Element? {
        try await first(where: { _ in true})
    }
}
