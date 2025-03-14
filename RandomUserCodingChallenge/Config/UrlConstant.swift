//
//  UrlConstant.swift
//  RandomUserCodingChallenge
//
//  Created by Pablo on 14/3/25.
//

import Foundation

enum UrlConstant {
    private static let hostUrl = URL(string: "https://randomuser.me/api")!
    
    static func randomUsersUrl(page: Int, results: Int) -> URL {
        return hostUrl.appending(queryItems: [URLQueryItem(name: "page", value: "\(page)"),
                                              URLQueryItem(name: "results", value: "\(results)")])
    }
}
