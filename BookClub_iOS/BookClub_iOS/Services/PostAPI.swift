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
    case updatePost(_ post: PostModel)
    case deletePost(_ bookId: Int)
    case doLikePost(_ bookId: Int)
    case undoLikePost(_ bookId: Int)
    case getTotalCount
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
        case .updatePost(let post):
            return "/\(post.postId)"
        case .deletePost(let bookId):
            return "/\(bookId)"
        case .doLikePost(let bookId):
            return "/\(bookId)"
        case .undoLikePost(let bookId):
            return "/\(bookId)"
        case .getTotalCount:
            return "/total-count"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPostsByBookId(_):
            return .get
        case .createPost(_):
            return .post
        case .updatePost(_):
            return .patch
        case .deletePost(_):
            return .delete
        case .doLikePost(_):
            return .post
        case .undoLikePost(_):
            return .post
        case .getTotalCount:
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
        case .updatePost(let post):
            return .requestJSONEncodable(post)
        case .deletePost(_):
            return .requestPlain
        case .doLikePost(_):
            return .requestPlain
        case .undoLikePost(_):
            return .requestPlain
        case .getTotalCount:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}
