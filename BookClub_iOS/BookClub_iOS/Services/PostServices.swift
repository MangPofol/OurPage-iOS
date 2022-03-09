//
//  PostServices.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/09/11.
//

import Foundation
import Moya
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
                        let decoder = JSONDecoder()
                        let dateFormat = DateFormatter().then {
                            $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                            $0.calendar = Calendar(identifier: .iso8601)
                            $0.locale = Locale(identifier: "ko_kr")
                        }
                        decoder.dateDecodingStrategy = .formatted(dateFormat)
                        let data = try decoder.decode(PostsResponse.self, from: $0.data)
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
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .formatted(.serverFormat)
                        let data = try decoder.decode(PostModel.self, from: $0.data)
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
    
    static func updatePost(post: PostToUpdate, postId: Int) -> Observable<PostModel?> {
        PostServices.provider
            .rx.request(.updatePost(post, postId: postId))
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .asObservable()
            .map {
                if $0.statusCode == 200 {
                    do {
                        let decoder = JSONDecoder()
                        let formatter = DateFormatter().then {
                            $0.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                        }
                        decoder.dateDecodingStrategy = .formatted(formatter)
                        let data = try decoder.decode(PostModel.self, from: $0.data)
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
    
    static func deletePost(postId: Int) -> Observable<Bool> {
        PostServices.provider
            .rx.request(.deletePost(postId))
            .asObservable()
            .map {
                return $0.statusCode == 204
            }
    }
    
    static func doLikePost(bookId: Int) {
        
    }
    
    static func undoLikePost(bookId: Int) {
        
    }
}
