import SwiftUI

struct RandomUserListCellView: View {
    let randomUser: RandomUser
    
    var body: some View {
        HStack {
            RandomUserProfileImageView(pictureURLString: randomUser.pictureURL, size: 60)
            VStack (alignment: .leading) {
                Text(randomUser.name ?? "")
                Text(randomUser.email ?? "")
                Text(randomUser.phone ?? "")
            }
            Spacer()
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
    RandomUserListCellView(randomUser: randomUser)
}
