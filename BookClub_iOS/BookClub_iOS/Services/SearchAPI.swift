//
//  SearchAPI.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/09/16.
//

import Foundation
import Moya

enum SearchAPI {
    case searchBookByTitle(_ title: String)
    case searchBookByisbn(_ isbn: String)
}

extension SearchAPI: TargetType {
    var baseURL: URL {
        return URL(string: Constants.SearchAPISource)!
    }
    
    var path: String {
        "/v3/search/book"
    }
    
    var method: Moya.Method {
        switch self {
        case .searchBookByisbn(_):
            return .get
        case .searchBookByTitle(_):
            return .get
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .searchBookByisbn(let isbn):
            return .requestParameters(parameters: ["query": isbn, "target": isbn], encoding: URLEncoding.default)
        case .searchBookByTitle(let title):
            return .requestParameters(parameters: ["query": title, "target": "title"], encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Authorization": Constants.daumKey]
    }
    
    
}
