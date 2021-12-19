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
    case getCurrentUserInfo
    case updateUser(user: UpdatingUser, id: String)
}

extension UserAPI: TargetType, AccessTokenAuthorizable {
    
    var authorizationType: AuthorizationType? {
        switch self {
        case .getCurrentUserInfo, .updateUser(_):
            return .bearer
        default:
            return nil
        }
    }
    
    var baseURL: URL {
        return URL(string: Constants.APISource)!
    }
    
    var path: String {
        switch self {
        case .validateDuplicate(_):
            return "/users/validate-duplicate"
        case .getCurrentUserInfo:
            return "/users/current"
        case .updateUser(_, let id):
            return "/users/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .validateDuplicate(_):
            return .post
        case .getCurrentUserInfo:
            return .get
        case .updateUser(_, _):
            return .put
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .validateDuplicate(let email):
            return .requestJSONEncodable(email)
        case .getCurrentUserInfo:
            return .requestPlain
        case .updateUser(let user, _):
            return .requestJSONEncodable(user)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
