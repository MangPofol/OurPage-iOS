//
//  FileServices.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/13.
//

import Foundation
import Moya
import RxSwift

class FileServices: Networkable {
    typealias Target = FileAPI
    static let provider = makeProvider()
    
    static func uploadFile(file: Data) -> Observable<String?> {
        FileServices.provider
            .rx.request(.uploadFile(file: file))
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .asObservable()
            .map {
                if $0.statusCode == 200 {
                    let url = String(bytes: $0.data, encoding: .utf8)
                    return url
                }
                return nil
            }
    }
    
    
    static func uploadFiles(with files: [Data]) -> Observable<[String]> {
        FileServices.provider
            .rx.request(.uploadFiles(files: files))
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .asObservable()
            .map {
                if $0.statusCode == 200 {
                    
                    let urls = try JSONDecoder().decode([String].self, from: $0.data)
                    return urls
                }
                return []
            }
    }
    
    static func deleteFiles(files: [String]) -> Observable<Bool> {
        FileServices.provider
            .rx.request(.delete(files: files))
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .asObservable()
            .map {
                return $0.statusCode == 204
            }
            
    }
}
