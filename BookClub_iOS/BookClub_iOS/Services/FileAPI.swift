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
    case delete(files: [String])
}

extension FileAPI: TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        return .bearer
    }
    
    var baseURL: URL {
        return URL(string: Constants.APISource)!
    }
    
    var path: String {
        switch self {
        case .upload(_):
            return "/files/upload-multiple-files"
        case .delete(_):
            return "/files/delete-multiple-files"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .upload(_):
            return .post
        case .delete(_):
            return .post
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
        case .delete(let files):
            let encoder = JSONEncoder()

            encoder.outputFormatting = .withoutEscapingSlashes
            
            return .requestCustomJSONEncodable(DeletingImages(images: files), encoder: encoder)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .upload(_):
            return ["Content-Type": "multipart / form-data"]
        case .delete(_):
            return nil
        }
        
    }
}

struct DeletingImages: Encodable {
    let images: [String]
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(images)
    }
}
