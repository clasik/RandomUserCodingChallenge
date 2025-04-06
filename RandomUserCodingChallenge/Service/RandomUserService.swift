import Combine
import Foundation

class RandomUserService {
    private let httpService: BaseService
    private var currentPage: Int
    
    init(httpService: HttpService = HttpService()) {
        self.httpService = httpService
        currentPage = 0
    }
    
    func getMoreRandomUsers() -> AnyPublisher<[RandomUser], Error> {
        let url = UrlConstant.randomUsersUrl(page: currentPage, results: 10)
        currentPage += 1
        return httpService
            .get(url: url)
            .decode(type: RandomUserResponse.self, decoder: JSONDecoder())
            .map { response in
                response.results.map { apiUser in
                    RandomUser(
                        gender: apiUser.gender,
                        name: "\(apiUser.name?.first ?? "") \(apiUser.name?.last ?? "")",
                        email: apiUser.email,
                        location: "\(apiUser.location?.street?.name ?? "") \(apiUser.location?.street?.number ?? 0) \(apiUser.location?.city ?? ""), \(apiUser.location?.state ?? "")",
                        phone: apiUser.phone,
                        registeredDate: apiUser.registered?.date,
                        pictureURL: apiUser.picture?.large
                    )
                }
            }
            .eraseToAnyPublisher()
    }
}
