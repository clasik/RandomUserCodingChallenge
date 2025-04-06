import SwiftUI

struct RandomUserListCellView: View {
    
    let randomUser: RandomUser
    
    var body: some View {
        HStack {
            if let pictureURLString = randomUser.pictureURL, let pictureURL = URL(string: pictureURLString) {
                AsyncImage(url: pictureURL) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                        .frame(width: 60, height: 60)
                }
            } else {
                Image(systemName: "person.circle").resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .clipShape(Circle())
            }
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
