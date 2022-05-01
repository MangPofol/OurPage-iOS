//
//  PostAPI.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/09/11.
//

import Foundation
import Moya

enum PostAPI {
    case getPostsByBookId(_ bookId: Int)
    case createPost(_ post: PostToCreate)
    case updatePost(_ post: PostToUpdate, postId: Int)
    case deletePost(_ postId: Int)
    case doLikePost(_ bookId: Int)
    case undoLikePost(_ bookId: Int)
    case getTotalCount
    case getPostsByBookIdAndClubId(bookId: Int, bookclubId: Int)
}

extension PostAPI: TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        return .bearer
    }
    
    var baseURL: URL {
        URL(string: Constants.APISource + "/posts")!
    }
    
    var path: String {
        switch self {
        case .getPostsByBookId(_):
            return ""
        case .createPost(_):
            return ""
        case .updatePost(_, let postId):
            return "/\(postId)"
        case .deletePost(let postId):
            return "/\(postId)"
        case .doLikePost(let bookId):
            return "/\(bookId)"
        case .undoLikePost(let bookId):
            return "/\(bookId)"
        case .getTotalCount:
            return "/total-count"
        case .getPostsByBookIdAndClubId(_, _):
            return ""
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPostsByBookId(_):
            return .get
        case .createPost(_):
            return .post
        case .updatePost(_, _):
            return .put
        case .deletePost(_):
            return .delete
        case .doLikePost(_):
            return .post
        case .undoLikePost(_):
            return .post
        case .getTotalCount:
            return .get
        case .getPostsByBookIdAndClubId(_,_):
            return .get
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .getPostsByBookId(let bookId):
            return .requestParameters(parameters: ["bookId": bookId], encoding: URLEncoding.default)
        case .createPost(let post):
            return .requestJSONEncodable(post)
        case .updatePost(let post, _):
            return .requestJSONEncodable(post)
        case .deletePost(_):
            return .requestPlain
        case .doLikePost(_):
            return .requestPlain
        case .undoLikePost(_):
            return .requestPlain
        case .getTotalCount:
            return .requestPlain
        case .getPostsByBookIdAndClubId(let bookId, let bookclubId):
            return .requestParameters(parameters: ["bookId": bookId, "clubId": bookclubId], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}
