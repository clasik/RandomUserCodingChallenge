import Foundation

enum UrlConstant {
    private static let hostUrl = URL(string: "https://randomuser.me/api")!
    
    static func randomUsersUrl(page: Int, results: Int) -> URL {
        hostUrl.appending(queryItems: [URLQueryItem(name: "page", value: "\(page)"),
                                       URLQueryItem(name: "results", value: "\(results)")])
    }
}
