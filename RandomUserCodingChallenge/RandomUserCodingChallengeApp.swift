//
//  RandomUserCodingChallengeApp.swift
//  RandomUserCodingChallenge
//
//  Created by Pablo on 14/3/25.
//

import SwiftUI
import SwiftData

@main
struct RandomUserCodingChallengeApp: App {
    
    let container: ModelContainer
    
    init() {
        do {
            container = try ModelContainer(for: RandomUser.self)
        } catch {
            fatalError("Failed to create ModelContainer for Movie.")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            RandomUserListView(modelContext: container.mainContext)
        }.modelContainer(container)
    }
}
