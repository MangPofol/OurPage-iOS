//
//  ClubAPI.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/25.
//

import Foundation
import Moya

enum ClubAPI {
    case getClubByUser
}

extension ClubAPI: TargetType, AccessTokenAuthorizable {
    var baseURL: URL {
        return URL(string: Constants.APISource)!
    }
    
    var path: String {
        switch self {
        case .getClubByUser:
            return "/clubs"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getClubByUser:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getClubByUser:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    var authorizationType: AuthorizationType? {
        switch self {
        case .getClubByUser:
            return .bearer
        }
    }
}
