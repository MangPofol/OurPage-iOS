//
//  FileServices.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/13.
//

import Foundation
import Moya
import RxMoya
import RxSwift

class FileServices {
    static let provider = MoyaProvider<FileAPI>()
    
    static func uploadFile(with files: [Data]) -> Observable<String?> {
        FileServices.provider
            .rx.request(.upload(files: files))
            .asObservable()
            .map {
                print($0)
                print(String(decoding: $0.data, as: UTF8.self))
                if $0.statusCode == 200 {
                    return String(decoding: $0.data, as: UTF8.self)
                }
                return nil
            }
    }
}
