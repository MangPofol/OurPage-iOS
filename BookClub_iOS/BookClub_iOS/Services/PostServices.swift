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

class PostServices: Networkable {
    typealias Target = PostAPI
    
    static let provider = makeProvider()
    
    struct PostsResponse: Codable {
        var data: [PostModel]
    }
    
    struct TotalCountResponse: Codable {
        var data: Int
    }
    
    static func getPostsByBookId(bookId: Int) -> Observable<[PostModel]> {
        PostServices.provider
            .rx.request(.getPostsByBookId(bookId))
            .asObservable()
            .map {
                if $0.statusCode == 200 {
                    do {
                        let data = try JSONDecoder().decode(PostsResponse.self, from: $0.data)
                        return data.data
                    } catch {
                        print(#fileID, #function, #line, error)
                        return []
                    }
                    
                    
                } else {
                    print("Failed with Status Code: \($0.statusCode)")
                    return []
                }
            }
            .catchAndReturn([])
    }
    
    static func createPost(post: PostToCreate) -> Observable<PostModel?> {
        PostServices.provider
            .rx.request(.createPost(post))
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .asObservable()
            .map {
                if $0.statusCode == 201 {
                    do {
                        let data = try JSONDecoder().decode(PostModel.self, from: $0.data)
                        return data
                    } catch {
                        print(error)
                        return nil
                    }
                    
                    
                } else {
                    return nil
                }
            }
    }
    
    static func getTotalCount() -> Observable<Int?> {
        PostServices.provider
            .rx.request(.getTotalCount)
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .asObservable()
            .map {
                if $0.statusCode == 200 {
                    let data = try JSONDecoder().decode(TotalCountResponse.self, from: $0.data)
                    return data.data
                }
                return nil
            }
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
