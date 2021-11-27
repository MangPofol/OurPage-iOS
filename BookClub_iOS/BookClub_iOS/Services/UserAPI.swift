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
    case login(email: String, password: String)
    case getUserInfor(userID: String)
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
        case .login(_, _):
            return "/login"
        case .getUserInfor(_):
            return "/users"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .validateDuplicate(_):
            return .post
        case .createUser(_):
            return .post
        case .login(_, _):
            return .post
        case .getUserInfor(_):
            return .get
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
        case .login(let email, let password):
            return .requestJSONEncodable(LoginUser(email: email, password: password))
        case .getUserInfor(let userID):
            return .requestParameters(parameters: ["userId": "\(userID)"], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
