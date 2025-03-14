//
//  RandomUserMock.swift
//  RandomUserCodingChallenge
//
//  Created by principal on 14/3/25.
//

import Foundation
@testable import RandomUserCodingChallenge

struct RandomUserMock {
    
    static let apiRandomUsersResponse = [ "results" : apiRandomUsers ]
    
    static let apiRandomUsers: [RandomUserResponse.APIUser] = [
        RandomUserResponse.APIUser(
            gender: "Male",
            name: .init(first: "John", last: "Doe"),
            location: .init(street: .init(name: "Main St", number: 123), city: "New York", state: "NY"),
            email: "john.doe_api@example.com",
            phone: "123-456-7890",
            registered: .init(date: "2023-01-15"),
            picture: .init(large: "https://randomuser.me/api/portraits/men/1.jpg")
        ),
        RandomUserResponse.APIUser(
            gender: "Female",
            name: .init(first: "Jane", last: "Smith"),
            location: .init(street: .init(name: "Sunset Blvd", number: 456), city: "Los Angeles", state: "CA"),
            email: "jane.smith_api@example.com",
            phone: "234-567-8901",
            registered: .init(date: "2022-11-23"),
            picture: .init(large: "https://randomuser.me/api/portraits/women/2.jpg")
        ),
        RandomUserResponse.APIUser(
            gender: "Male",
            name: .init(first: "Michael", last: "Brown"),
            location: .init(street: .init(name: "Lake Rd", number: 789), city: "Chicago", state: "IL"),
            email: "michael.brown_api@example.com",
            phone: "345-678-9012",
            registered: .init(date: "2021-09-10"),
            picture: .init(large: "https://randomuser.me/api/portraits/men/3.jpg")
        ),
        RandomUserResponse.APIUser(
            gender: "Female",
            name: .init(first: "Emily", last: "Johnson"),
            location: .init(street: .init(name: "Broadway", number: 321), city: "Houston", state: "TX"),
            email: "emily.johnson_api@example.com",
            phone: "456-789-0123",
            registered: .init(date: "2020-07-05"),
            picture: .init(large: "https://randomuser.me/api/portraits/women/4.jpg")
        ),
        RandomUserResponse.APIUser(
            gender: "Male",
            name: .init(first: "David", last: "Wilson"),
            location: .init(street: .init(name: "Park Ave", number: 654), city: "Phoenix", state: "AZ"),
            email: "david.wilson_api@example.com",
            phone: "567-890-1234",
            registered: .init(date: "2019-05-30"),
            picture: .init(large: "https://randomuser.me/api/portraits/men/5.jpg")
        ),
        RandomUserResponse.APIUser(
            gender: "Female",
            name: .init(first: "Sophia", last: "Martinez"),
            location: .init(street: .init(name: "Elm St", number: 987), city: "Philadelphia", state: "PA"),
            email: "sophia.martinez_api@example.com",
            phone: "678-901-2345",
            registered: .init(date: "2018-03-15"),
            picture: .init(large: "https://randomuser.me/api/portraits/women/6.jpg")
        ),
        RandomUserResponse.APIUser(
            gender: "Male",
            name: .init(first: "James", last: "Anderson"),
            location: .init(street: .init(name: "Ocean Dr", number: 741), city: "San Antonio", state: "TX"),
            email: "james.anderson_api@example.com",
            phone: "789-012-3456",
            registered: .init(date: "2017-01-20"),
            picture: .init(large: "https://randomuser.me/api/portraits/men/7.jpg")
        ),
        RandomUserResponse.APIUser(
            gender: "Female",
            name: .init(first: "Olivia", last: "Thomas"),
            location: .init(street: .init(name: "Bay St", number: 852), city: "San Diego", state: "CA"),
            email: "olivia.thomas_api@example.com",
            phone: "890-123-4567",
            registered: .init(date: "2016-12-12"),
            picture: .init(large: "https://randomuser.me/api/portraits/women/8.jpg")
        ),
        RandomUserResponse.APIUser(
            gender: "Male",
            name: .init(first: "Daniel", last: "White"),
            location: .init(street: .init(name: "Hill Rd", number: 963), city: "Dallas", state: "TX"),
            email: "daniel.white_api@example.com",
            phone: "901-234-5678",
            registered: .init(date: "2015-10-08"),
            picture: .init(large: "https://randomuser.me/api/portraits/men/9.jpg")
        ),
        RandomUserResponse.APIUser(
            gender: "Female",
            name: .init(first: "Isabella", last: "Lee"),
            location: .init(street: .init(name: "Pine St", number: 159), city: "San Jose", state: "CA"),
            email: "isabella.lee_api@example.com",
            phone: "012-345-6789",
            registered: .init(date: "2014-08-03"),
            picture: .init(large: "https://randomuser.me/api/portraits/women/10.jpg")
        )
    ]
    
    static let randomUsers: [RandomUser] = [
        RandomUser(gender: "Male", name: "John Doe", email: "john.doe@example.com", location: "New York, USA", phone: "123-456-7890", registeredDate: "2023-01-15", pictureURL: "https://randomuser.me/api/portraits/men/1.jpg"),
        RandomUser(gender: "Female", name: "Jane Smith", email: "jane.smith@example.com", location: "Los Angeles, USA", phone: "234-567-8901", registeredDate: "2022-11-23", pictureURL: "https://randomuser.me/api/portraits/women/2.jpg"),
        RandomUser(gender: "Male", name: "Michael Brown", email: "michael.brown@example.com", location: "Chicago, USA", phone: "345-678-9012", registeredDate: "2021-09-10", pictureURL: "https://randomuser.me/api/portraits/men/3.jpg"),
        RandomUser(gender: "Female", name: "Emily Johnson", email: "emily.johnson@example.com", location: "Houston, USA", phone: "456-789-0123", registeredDate: "2020-07-05", pictureURL: "https://randomuser.me/api/portraits/women/4.jpg"),
        RandomUser(gender: "Male", name: "David Wilson", email: "david.wilson@example.com", location: "Phoenix, USA", phone: "567-890-1234", registeredDate: "2019-05-30", pictureURL: "https://randomuser.me/api/portraits/men/5.jpg"),
        RandomUser(gender: "Female", name: "Sophia Martinez", email: "sophia.martinez@example.com", location: "Philadelphia, USA", phone: "678-901-2345", registeredDate: "2018-03-15", pictureURL: "https://randomuser.me/api/portraits/women/6.jpg"),
        RandomUser(gender: "Male", name: "James Anderson", email: "james.anderson@example.com", location: "San Antonio, USA", phone: "789-012-3456", registeredDate: "2017-01-20", pictureURL: "https://randomuser.me/api/portraits/men/7.jpg"),
        RandomUser(gender: "Female", name: "Olivia Thomas", email: "olivia.thomas@example.com", location: "San Diego, USA", phone: "890-123-4567", registeredDate: "2016-12-12", pictureURL: "https://randomuser.me/api/portraits/women/8.jpg"),
        RandomUser(gender: "Male", name: "Daniel White", email: "daniel.white@example.com", location: "Dallas, USA", phone: "901-234-5678", registeredDate: "2015-10-08", pictureURL: "https://randomuser.me/api/portraits/men/9.jpg"),
        RandomUser(gender: "Female", name: "Isabella Lee", email: "isabella.lee@example.com", location: "San Jose, USA", phone: "012-345-6789", registeredDate: "2014-08-03", pictureURL: "https://randomuser.me/api/portraits/women/10.jpg", isHidden: true)
    ]
}
