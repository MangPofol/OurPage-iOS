//
//  AuthAPI.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/09/29.
//

import Foundation
import Moya

enum AuthAPI {
    case login(_ id: String, _ password: String)
}

extension AuthAPI: TargetType {
    var baseURL: URL {
        URL(string: Constants.APISource)!
    }
    
    var path: String {
        "/login"
    }
    
    var method: Moya.Method {
        .post
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .login(let id, let password):
            return .requestJSONEncodable(LoginInfo(email: id, password: password))
        }
    }
    
    var headers: [String : String]? {
        ["Content-Type": "application/json"]
    }
}

struct LoginInfo: Codable {
    var email: String
    var password: String
}
