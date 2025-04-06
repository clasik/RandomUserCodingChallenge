import SwiftUI

struct RandomUserDetailView: View {
    let randomUser: RandomUser
    
    var body: some View {
        VStack {
            RandomUserProfileImageView(pictureURLString: randomUser.pictureURL, size: 100)
            Text("Gender: \(randomUser.gender ?? "")")
            Text("Name: \(randomUser.name ?? "")")
            Text("Location: \(randomUser.location ?? "")")
            Text("Email: \(randomUser.email ?? "")")
            Text("Registered date: \(randomUser.registeredDate ?? "")")
        }
    }
}

#Preview {
    let randomUser = RandomUser (
        gender: "X",
        name: "John Doe",
        email: "johndoe@example.com",
        location: "Street 123, City, Country",
        phone: "123-456-7890",
        registeredDate: "2025-03-14",
        pictureURL: "https://example.com/pic.jpg"
    )
    RandomUserDetailView(randomUser: randomUser)
}

