//
//  AuthAPI.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/09/29.
//

import Foundation
import Moya

enum AuthAPI {
    case createUser(_ creatingUser: CreatingUser)
    case login(_ id: String, _ password: String)
}

extension AuthAPI: TargetType {
    var baseURL: URL {
        URL(string: Constants.APISource)!
    }
    
    var path: String {
        switch self {
        case .createUser(_):
            return "/auth/signup"
        case .login(_, _):
            return "/auth/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createUser(_):
            return .post
        case .login(_, _):
            return .post
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .createUser(let creatingUser):
            return .requestJSONEncodable(creatingUser)
        case .login(let id, let password):
            return .requestJSONEncodable(LoginInfo(email: id, password: password))
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}

struct LoginInfo: Codable {
    var email: String
    var password: String
}
