//
//  BookclubAPI.swift
//  BookClub_iOS
//
//  Created by Nam Jun Lee on 2022/03/31.
//

import Foundation
import Moya

enum BookclubAPI {
    case createBookclub(creatingBookclub: CreatingBookclub)
    case getClubsByUser(id: Int)
    case getClubInfoByClub(id: Int)
}

extension BookclubAPI: TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        return .bearer
    }
    
    var baseURL: URL {
        return URL(string: Constants.APISource)!
    }
    
    var path: String {
        switch self {
        case .createBookclub(_), .getClubsByUser(_):
            return "/clubs"
        case .getClubInfoByClub(let id):
            return "/clubs/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createBookclub(_):
            return .post
        case .getClubsByUser(_):
            return .get
        case .getClubInfoByClub(_):
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .createBookclub(let creatingBookclub):
            return .requestJSONEncodable(creatingBookclub)
        case .getClubsByUser(let id):
            return .requestParameters(parameters: ["userId": "\(id)"], encoding: URLEncoding.default)
        case .getClubInfoByClub(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
