import Combine
import Foundation

protocol HttpBaseService {
    func get(url: URL) -> AnyPublisher<Data, URLError>
}

struct HttpService: HttpBaseService {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func get(url: URL) -> AnyPublisher<Data, URLError> {
        urlSession
            .dataTaskPublisher(for: url)
            .map(\.data)
            .eraseToAnyPublisher()
    }
}
