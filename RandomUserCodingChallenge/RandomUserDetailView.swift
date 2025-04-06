import SwiftUI

struct RandomUserDetailView: View {
    
    let randomUser: RandomUser
    
    var body: some View {
        VStack {
            if let pictureURLString = randomUser.pictureURL, let pictureURL = URL(string: pictureURLString) {
                AsyncImage(url: pictureURL) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                        .frame(width: 100, height: 100)
                }
            } else {
                Image(systemName: "person.circle").resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
            }
            
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

