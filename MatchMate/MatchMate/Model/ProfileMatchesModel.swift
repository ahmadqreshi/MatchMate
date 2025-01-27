//
//  ProfileMatchesModel.swift
//  MatchMate
//
//  Created by Ahmad Qureshi on 27/01/25.
//

import Foundation

enum MatchStatus: String, Codable {
    case accepted
    case pending
    case rejected
}

struct ProfileMatchesModel: Codable {
    let id: String
    let imageUrl: String
    let name: String
    let address: String
    var status: String
    
    // To Handle only Single source of data
    static func build(response: ServerResponse) -> [Self] {
        var matches: [Self] = []
        response.results.forEach { user in
            let id =  user.id?.value ?? UUID().uuidString
            let imageUrl = user.picture?.large ?? ""
            let name = "\(user.name?.first ?? "") \(user.name?.last ?? "")"
            let address = "\(user.location?.street?.number ?? 000) \(user.location?.street?.name ?? ""), \(user.location?.city ?? ""), \(user.location?.state ?? "")"
            let matchStatus: String = MatchStatus.pending.rawValue
            let profileMatchModel = ProfileMatchesModel(id: id, imageUrl: imageUrl, name: name, address: address, status: matchStatus)
            matches.append(profileMatchModel)
        }
        return matches
    }
}
