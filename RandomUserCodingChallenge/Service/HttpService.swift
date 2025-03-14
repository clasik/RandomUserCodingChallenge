//
//  HttpService.swift
//  RandomUserCodingChallenge
//
//  Created by Pablo on 14/3/25.
//

import Combine
import Foundation

protocol BaseService {
    func get(url: URL) -> AnyPublisher<Data, URLError>
}

class HttpService: BaseService {
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
