//
//  ClubServices.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/25.
//

import Foundation

import Moya
import RxSwift

class ClubServices: Networkable {
    typealias Target = ClubAPI
    
    static let provider = makeProvider()
    
    static func getClubByUser() -> Observable<[Club]> {
        ClubServices.provider
            .rx.request(.getClubByUser)
            .observe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .asObservable()
            .map {
                if $0.statusCode == 200 {
                    let response = try? JSONDecoder().decode(GetClubResponse.self, from: $0.data)
                    return response!.data
                }
                return []
            }
            .catchAndReturn([])
    }
}

struct GetClubResponse: Codable {
    var data: [Club]
}
