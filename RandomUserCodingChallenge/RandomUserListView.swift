import SwiftUI
import SwiftData

struct RandomUserListView: View {
    
    @ObservedObject private var randomUserListViewModel: RandomUserListViewModel
    @State private var searchQuery = ""
    
    init(modelContext: ModelContext) {
        randomUserListViewModel = RandomUserListViewModel(swiftDataService: SwiftDataService(modelContext: modelContext))
    }
    
    private var indicatorView: some View {
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle())
            .controlSize(.large)
    }
    
    private var randomUsers: [RandomUser] {
        randomUserListViewModel.randomUsers.compactMap { $0 }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(randomUsers.indices, id: \.self) { index in
                    let randomUser = randomUsers[index]
                    NavigationLink {
                        RandomUserDetailView(randomUser: randomUser)
                    } label: {
                        RandomUserListCellView(randomUser: randomUser)
                            .onAppear {
                                if index == randomUsers.count - 1 && !randomUserListViewModel.showIndicator && searchQuery.isEmpty {
                                    randomUserListViewModel.fetchMoreData()
                                }
                            }
                    }
                }
                .onDelete(perform: randomUserListViewModel.delete)
            }
            .searchable(
                text: $searchQuery,
                placement: .automatic,
                prompt: "Filter users by name, surname or email"
            )
            .textInputAutocapitalization(.never)
            .onChange(of: searchQuery) {
                randomUserListViewModel.fetchSearchResults(for: searchQuery)
            }
            .overlay {
                if randomUserListViewModel.showIndicator {
                    VStack {
                        Spacer()
                        indicatorView
                    }
                }
            }
            .navigationDestination(for: RandomUser.self) { randomUser in
                RandomUserDetailView(randomUser: randomUser)
            }
            .navigationTitle("Users: \(randomUserListViewModel.randomUsers.count)")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        randomUserListViewModel.filterHiddenUsers(!randomUserListViewModel.showHiddenUsers)
                    }) {
                        Image(systemName: randomUserListViewModel.showHiddenUsers ?  "person.fill" : "person.badge.minus.fill")
                            .resizable()
                            .frame(width: 24, height: 24)
                    }
                }
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: RandomUser.self, configurations: config)
        return RandomUserListView(modelContext: container.mainContext)
    } catch {
        fatalError("Failed to create model container.")
    }
}
