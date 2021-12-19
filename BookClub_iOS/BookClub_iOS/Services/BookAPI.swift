//
//  BookAPI.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/09/10.
//

import Foundation
import Moya

enum BookAPI {
    case getBooksByCurrentUserAndCategory(_ category: String)
    case createBook(_ bookToCreate: BookToCreate)
    case updateBook(_ id: String, _ bookToCreate: BookToCreate)
    case deleteBook(_ id: String)
    case doLikeBook(_ id: String)
    case undoLikeBook(_ id: String)
}

extension BookAPI: TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        switch self {
        case .getBooksByCurrentUserAndCategory(_):
            return .bearer
        default:
            return nil
        }
    }
    
    var baseURL: URL {
        return URL(string: Constants.APISource + "/books")!
    }
    
    var path: String {
        switch self {
        case .getBooksByCurrentUserAndCategory(_):
            return ""
        case .createBook(_):
            return ""
        case .updateBook(let id, _):
            return "/\(id)"
        case .deleteBook(let id):
            return "/\(id)"
        case .doLikeBook(let id):
            return "/\(id)/do-like"
        case .undoLikeBook(let id):
            return "/\(id)/undo-like"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getBooksByCurrentUserAndCategory(_):
            return .get
        case .createBook(_):
            return .post
        case .updateBook(_, _):
            return .patch
        case .deleteBook(_):
            return .delete
        case .doLikeBook(_):
            return .post
        case .undoLikeBook(_):
            return .post
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .getBooksByCurrentUserAndCategory(let category):
            return .requestParameters(parameters: ["category": category], encoding: URLEncoding.default)
        case .createBook(let bookToCreate):
            return .requestJSONEncodable(bookToCreate)
        case .updateBook(_, let bookToCreate):
            return .requestJSONEncodable(bookToCreate)
        case .deleteBook(_):
            return .requestPlain
        case .doLikeBook(_):
            return .requestPlain
        case .undoLikeBook(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
