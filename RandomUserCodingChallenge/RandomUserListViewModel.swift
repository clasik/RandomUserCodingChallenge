import Foundation
import Combine
import SwiftData

class RandomUserListViewModel: ObservableObject {
    
    private let swiftDataService: SwiftDataBaseService
    private let randomUserService: RandomUserService
    private var cancellable = Set<AnyCancellable>()
    private var randomUsersStore: [RandomUser] = []
    private var currentPage = 0
    
    @Published var randomUsers: [RandomUser] = []
    @Published var showIndicator = false
    @Published var showHiddenUsers = false
    
    init(swiftDataService: SwiftDataBaseService, randomUserService: RandomUserService = RandomUserService()) {
        self.swiftDataService = swiftDataService
        self.randomUserService = randomUserService
        randomUsersStore = swiftDataService.fetchRandomUser()
        randomUsers = randomUsersStore.filter { $0.isHidden == showHiddenUsers }
        if randomUsersStore.isEmpty {
            fetchMoreData()
        }
    }
    
    func fetchMoreData() {
        showIndicator = true
        randomUserService.getMoreRandomUsers(page: currentPage)
            .receive(on: RunLoop.main)
            .map { result in
                result.map { apiUser in
                    RandomUser(
                        gender: apiUser.gender,
                        name: "\(apiUser.name?.first ?? "") \(apiUser.name?.last ?? "")",
                        email: apiUser.email,
                        location: "\(apiUser.location?.street?.name ?? "") \(apiUser.location?.street?.number ?? 0) \(apiUser.location?.city ?? ""), \(apiUser.location?.state ?? "")",
                        phone: apiUser.phone,
                        registeredDate: apiUser.registered?.date,
                        pictureURL: apiUser.picture?.large
                    )
                }
            }
            .sink { completion in
                self.completionHandler(completion, message: "Random Users Loaded")
            } receiveValue: { fetchedUsers in
                let newUsers = fetchedUsers.filter { !self.randomUsersStore.contains($0) }
                self.swiftDataService.insertRandomUsers(newUsers)
                self.randomUsersStore.append(contentsOf: newUsers)
                self.randomUsers = self.randomUsersStore.filter { $0.isHidden == self.showHiddenUsers }
            }
            .store(in: &cancellable)
        currentPage+=1
    }
    
    func delete(at offsets: IndexSet) {
        offsets.map { self.randomUsers[$0] }
            .forEach { self.swiftDataService.hideUser($0) }
    }
    
    func fetchSearchResults(for query: String) {
        if query.count == 0 {
            self.randomUsers = self.randomUsersStore.filter { $0.isHidden == self.showHiddenUsers }
            return
        }
        randomUsers = self.randomUsersStore.filter { randomUser in
            randomUser.description
                .lowercased()
                .contains(query.lowercased()) &&
            randomUser.isHidden == showHiddenUsers
        }
    }
    
    func filterHiddenUsers(_ showHiddenUsers : Bool) {
        self.showHiddenUsers = showHiddenUsers
        self.randomUsers = self.randomUsersStore.filter { $0.isHidden == self.showHiddenUsers }
    }
    
    fileprivate func completionHandler(_ completion: Subscribers.Completion<any Error>, message: String) {
        self.showIndicator = false
        switch completion {
        case .finished:
            print(message)
        case let .failure(error):
            print(error)
        }
    }
}
