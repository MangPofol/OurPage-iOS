//
//  UserAPI.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/29.
//

import Foundation
import Moya

struct EmailStruct: Codable {
    var email: String
}

enum UserAPI {
    case validateDuplicate(email: EmailStruct)
    case createUser(user: CreatingUser)
}

extension UserAPI: TargetType {
    var baseURL: URL {
        return URL(string: Constants.APISource)!
    }
    
    var path: String {
        switch self {
        case .validateDuplicate(_):
            return "/users/validate-duplicate"
        case .createUser(_):
            return "/users"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .validateDuplicate(_):
            return .post
        case .createUser(_):
            return .post
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .validateDuplicate(let email):
            return .requestJSONEncodable(email)
        case .createUser(let user):
            return .requestJSONEncodable(user)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    
}
