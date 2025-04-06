import SwiftData
import Foundation

protocol SwiftDataBaseService {
    func fetchRandomUser() -> [RandomUser]
    func insertRandomUsers(_ randomUsers: [RandomUser])
    func hideUser(_ user: RandomUser)
}

struct SwiftDataService: SwiftDataBaseService {
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func fetchRandomUser() -> [RandomUser] {
        do {
            return try modelContext.fetch(FetchDescriptor<RandomUser>(sortBy: [SortDescriptor(\.addedDate)]))
        } catch {
            print("Fetch failed")
        }
        return []
    }
    
    func insertRandomUsers(_ randomUsers: [RandomUser]) {
        for user in randomUsers {
            modelContext.insert(user)
        }
        do {
            try modelContext.save()
        } catch {
            print("insertRandomUsers - Save failed")
        }
    }
    
    func hideUser(_ user: RandomUser) {
        user.isHidden = true
        do {
            try modelContext.save()
        } catch {
            print("hideUser - Save failed")
        }
    }
}
