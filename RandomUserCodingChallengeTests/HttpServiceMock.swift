import Combine
import Foundation
@testable import RandomUserCodingChallenge

struct HttpServiceMock: HttpBaseService {
    func get(url: URL) -> AnyPublisher<Data, URLError> {
        let encoder = JSONEncoder()
        do {
            let mockData = try encoder.encode(RandomUserMock.apiRandomUsersResponse)
            return Just(mockData)
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: URLError(.badServerResponse))
                .eraseToAnyPublisher()
        }
    }
}
