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
        case .createBookclub(_):
            return "/clubs"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .createBookclub(_):
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .createBookclub(let creatingBookclub):
            return .requestJSONEncodable(creatingBookclub)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
