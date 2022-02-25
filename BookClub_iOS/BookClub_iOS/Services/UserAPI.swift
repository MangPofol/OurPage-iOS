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

struct NewPasswordStruct: Codable {
    var password: String
}

enum UserAPI {
    case validateDuplicate(email: EmailStruct)
    case getCurrentUserInfo
    case updateUser(user: UpdatingUser, id: Int)
    case validateEmail
    case validateEmailSendCode(emailCode: String)
    case changePassword(newPassword: String)
    case changeUserDormant(id: Int)
}

extension UserAPI: TargetType, AccessTokenAuthorizable {
    
    var authorizationType: AuthorizationType? {
        switch self {
        case .getCurrentUserInfo, .updateUser(_, _), .validateEmail, .validateEmailSendCode(_), .changePassword(_), .changeUserDormant(_):
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
        case .validateEmail:
            return "/users/validate-email"
        case .validateEmailSendCode(_):
            return "/users/validate-email-send-code"
        case .changePassword(_):
            return "/users/change-pw"
        case .changeUserDormant(let id):
            return "/users/\(id)/change-dormant"
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
        case .validateEmail, .validateEmailSendCode(_):
            return .post
        case .changePassword(_):
            return .post
        case .changeUserDormant(_):
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
        case .getCurrentUserInfo:
            return .requestPlain
        case .updateUser(let user, _):
            return .requestJSONEncodable(user)
        case .validateEmail:
            return .requestPlain
        case .validateEmailSendCode(let emailCode):
            return .requestParameters(parameters: ["emailCode": emailCode], encoding: URLEncoding.default)
        case .changePassword(let newPassword):
            return .requestJSONEncodable(NewPasswordStruct(password: newPassword))
        case .changeUserDormant(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
}
