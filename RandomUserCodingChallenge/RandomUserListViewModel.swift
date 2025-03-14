//
//  RandomUserListViewModel.swift
//  RandomUserCodingChallenge
//
//  Created by Pablo on 14/3/25.
//

import Foundation
import Combine
import SwiftData

class RandomUserListViewModel: ObservableObject {
    
    private let modelContext: ModelContext
    private let randomUserService: RandomUserService
    private var cancellable = Set<AnyCancellable>()
    private var randomUsersStore: [RandomUser] = []
    
    @Published var randomUsers: [RandomUser] = []
    @Published var showIndicator = false
    @Published var showHiddenUsers = false
    
    init(modelContext: ModelContext, randomUserService: RandomUserService = RandomUserService()) {
        self.modelContext = modelContext
        self.randomUserService = randomUserService
        randomUsers = []
        randomUsersStore = []
        fetchSwiftData()
        if randomUsersStore.isEmpty {
            fetchMoreData()
        }
    }
    
    private func fetchSwiftData() {
        do {
            let descriptor = FetchDescriptor<RandomUser>(sortBy: [SortDescriptor(\.addedDate)])
            randomUsersStore = try modelContext.fetch(descriptor)
            randomUsers = randomUsersStore.filter { $0.isHidden == showHiddenUsers }
        } catch {
            print("Fetch failed")
        }
    }
    
    func fetchMoreData() {
        showIndicator = true
        randomUserService.getMoreRandomUsers()
            .receive(on: RunLoop.main)
            .sink { completion in
                self.completionHandler(completion, message: "Random Users Loaded")
            } receiveValue: { fetchedUsers in
                let newUsers = fetchedUsers.filter { !self.randomUsersStore.contains($0) }
                for user in newUsers {
                    self.modelContext.insert(user)
                }
                try? self.modelContext.save()
                self.randomUsersStore.append(contentsOf: newUsers)
                self.randomUsers = self.randomUsersStore.filter { $0.isHidden == self.showHiddenUsers }
            }
            .store(in: &cancellable)
    }
    
    func delete(at offsets: IndexSet) {
        offsets.map { self.randomUsers[$0] }
            .forEach { $0.isHidden = true }
        try? modelContext.save()
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
