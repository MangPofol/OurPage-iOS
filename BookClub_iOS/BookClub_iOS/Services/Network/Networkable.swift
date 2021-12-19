//
//  Networkable.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/12/18.
//

import Moya

protocol Networkable {
    associatedtype Target: TargetType
    static func makeProvider() -> MoyaProvider<Target>
}

extension Networkable {
    static func makeProvider() -> MoyaProvider<Target> {
        let authPlugin = AccessTokenPlugin { _ in
            return KeyChainController.shared.getAuthorizationString(service: Constants.ServiceString, account: "Token") ?? ""
        }
        
        let loggerPlugin = NetworkLoggerPlugin()
        
        return MoyaProvider<Target>(plugins: [authPlugin, loggerPlugin])
    }
}
