import SwiftUI
import SwiftData

@main
struct RandomUserCodingChallengeApp: App {
    
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: RandomUser.self)
        } catch {
            fatalError("Failed to create ModelContainer for RandomUser.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            RandomUserListView(modelContext: container.mainContext)
        }.modelContainer(container)
    }
}
