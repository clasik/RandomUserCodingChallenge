import SwiftUI

struct RandomUserProfileImageView: View {
    let pictureURLString: String?
    let size: CGFloat
    
    var body: some View {
        if let pictureURLString = pictureURLString, let pictureURL = URL(string: pictureURLString) {
            AsyncImage(url: pictureURL) { image in
                image.resizable()
                    .scaledToFit()
                    .frame(width: size, height: size)
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
                    .frame(width: size, height: size)
            }
        } else {
            Image(systemName: "person.circle").resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .clipShape(Circle())
        }
    }
}

#Preview {
    RandomUserProfileImageView(pictureURLString: "https://example.com/pic.jpg", size: 100)
}

