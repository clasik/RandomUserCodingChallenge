import Combine
import Foundation

struct RandomUserService {
    private let httpService: HttpBaseService
    
    init(httpService: HttpBaseService = HttpService()) {
        self.httpService = httpService
    }
    
    func getMoreRandomUsers(page: Int) -> AnyPublisher<[RandomUserAPIUser], Error> {
        httpService
            .get(url: UrlConstant.randomUsersUrl(page: page, results: 10))
            .decode(type: RandomUserResponse.self, decoder: JSONDecoder())
            .map { $0.results }
            .eraseToAnyPublisher()
    }
}
