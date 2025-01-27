//
//  ServerResponseModel.swift
//  MatchMate
//
//  Created by Ahmad Qureshi on 27/01/25.
//

import Foundation
struct ServerResponse: Codable {
    let results: [User]
    let info: Info
}

// MARK: - Info
struct Info: Codable {
    let seed: String?
    let results, page: Int?
    let version: String?
}

// MARK: - Result
struct User: Codable {
    let gender: String?
    let name: Name?
    let location: UserAddress?
    let email: String?
    let login: LoginDetail?
    let dob, registered: Dob?
    let phone, cell: String?
    let id: userId?
    let picture: Picture?
    let nat: String?
}

// MARK: - Dob
struct Dob: Codable {
    let date: String?
    let age: Int?
}

// MARK: - ID
struct userId: Codable {
    let name: String?
    let value: String?
}

// MARK: - Location
struct UserAddress: Codable {
    let street: Street?
    let city, state, country: String?
}

// MARK: - Coordinates
struct Coordinates: Codable {
    let latitude, longitude: String?
}

// MARK: - Street
struct Street: Codable {
    let number: Int?
    let name: String?
}

// MARK: - Timezone
struct Timezone: Codable {
    let offset, description: String?
}

// MARK: - Login
struct LoginDetail: Codable {
    let uuid, username, password, salt: String?
    let md5, sha1, sha256: String?
}

// MARK: - Name
struct Name: Codable {
    let title, first, last: String?
}

// MARK: - Picture
struct Picture: Codable {
    let large, medium, thumbnail: String?
}
