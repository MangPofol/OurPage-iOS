//
//  PostServices.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/09/11.
//

import Foundation
import Moya
import RxMoya
import RxSwift

class PostServices {
    static let provider = MoyaProvider<PostAPI>()
    
    struct PostsResponse: Codable {
        var data: [PostModel]
    }
    
    static func getPostsByBookId(bookId: Int) -> Observable<[PostModel]> {
        PostServices.provider
            .rx.request(.getPostsByBookId(bookId))
            .asObservable()
            .map {
                if $0.statusCode == 200 {
                    let data = try JSONDecoder().decode(PostsResponse.self, from: $0.data)
                    return data.data
                } else {
                    print("Failed with Status Code: \($0.statusCode)")
                    return []
                }
            }
            .catchErrorJustReturn([])
    }
    
    static func createPost(post: PostToCreate) -> Observable<PostToCreate?> {
        PostServices.provider
            .rx.request(.createPost(post))
            .asObservable()
            .map {
                if $0.statusCode == 201 {
                    let data = try JSONDecoder().decode(PostToCreate.self, from: $0.data)
                    return data
                } else {
                    print("Failed with Status Code: \($0.statusCode)")
                    return nil
                }
            }
            .catchErrorJustReturn(nil)
    }
    
    static func updatePost(post: PostModel) {
        
    }
    
    static func deletePost(bookId: Int) {
        
    }
    
    static func doLikePost(bookId: Int) {
        
    }
    
    static func undoLikePost(bookId: Int) {
        
    }
}
