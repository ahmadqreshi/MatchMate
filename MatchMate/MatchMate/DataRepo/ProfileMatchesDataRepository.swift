//
//  ProfileMatchesDataRepository.swift
//  MatchMate
//
//  Created by Ahmad Qureshi on 27/01/25.
//

import Foundation
import SystemConfiguration


class ProfileMatchesDataRepository {
    // check network status
    // based on network availability fetch data from server or core data
    func fetchProfileMatches(success: @escaping ([ProfileMatchesModel]) -> Void, failure: @escaping (String) -> Void) {
        if isConnectedToNetwork() {
            NetworkManager.shared.request(resultType: ServerResponse.self, endpoint: .fetchProfileMatches) { response in
                switch response {
                case .success(let data):
                    let result = ProfileMatchesModel.build(response: data)
                    // Save Result into Core Data
                    result.forEach { user in
                        if !CoreDataManager.shared.checkExistence(objectType: UserMatches.self, id: user.id, predicate: "id").0 {
                            let object = CoreDataManager.shared.create(objectType: UserMatches.self)
                            object.name = user.name
                            object.address = user.address
                            object.status = user.status
                            object.id = user.id
                            object.imageUrl = user.imageUrl
                            CoreDataManager.shared.saveContext()
                        }
                    }
                    
                    success(result)
                case .failure(let error):
                    switch error {
                    case .urlError:
                        failure("url is invalid")
                    case .decodingProblem :
                        failure("response problem")
                    case .responseProblem :
                        failure("response problem")
                    case .failureMessage(let message) :
                        failure(message)
                    }
                }
            }
        } else {
            let fetchObjects = CoreDataManager.shared.fetch(objectType: UserMatches.self)
            var result: [ProfileMatchesModel] = []
            fetchObjects.forEach { object in
                var jsonObject = [String: Any]()
                for key in object.entity.attributesByName.keys {
                    jsonObject[key] = object.value(forKey: key)
                }
                let jsonData = try! JSONSerialization.data(withJSONObject: jsonObject, options: [])
                let model = try! JSONDecoder().decode(ProfileMatchesModel.self, from: jsonData)
                result.append(model)
            }
            success(result)
        }
    }
    
    
    func isConnectedToNetwork() -> Bool {
           var zeroAddress = sockaddr_in()
           zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
           zeroAddress.sin_family = sa_family_t(AF_INET)
           
           guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
               $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                   SCNetworkReachabilityCreateWithAddress(nil, $0)
               }
           }) else {
               return false
           }
           
           var flags: SCNetworkReachabilityFlags = []
           if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
               return false
           }
           
           let isReachable = flags.contains(.reachable)
           let needsConnection = flags.contains(.connectionRequired)
           
           return (isReachable && !needsConnection)
       }
}
