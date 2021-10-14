//
//  FileAPI.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/13.
//

import Foundation
import Moya

enum FileAPI {
    case upload(files: [Data])
}

extension FileAPI: TargetType {
    var baseURL: URL {
        return URL(string: Constants.APISource)!
    }
    
    var path: String {
        switch self {
        case .upload(_):
            return "/files/upload-multiple-files"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .upload(_):
            return .put
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Task {
        switch self {
        case .upload(let files):
            let fileMFDataArray: [MultipartFormData] = files.enumerated().map({ (index, data) in
                MultipartFormData(provider: .data(data),
                                  name: "data", //This is the key
                                  fileName: "\(Int(Date().timeIntervalSince1970)) \(index)",
                                  mimeType: "multipart/form-data")
            })
        
            return .uploadMultipart(fileMFDataArray)
        }
    }
    
    var headers: [String : String]? {
        ["Content-Type": "multipart / form-data"]
    }
    
    
}
