//
//  FileAPI.swift
//  BookClub_iOS
//
//  Created by Lee Nam Jun on 2021/10/13.
//

import Foundation
import Moya

enum FileAPI {
    case uploadFile(file: Data)
    case uploadFiles(files: [Data])
    case delete(files: [String])
}

extension FileAPI: TargetType, AccessTokenAuthorizable {
    var authorizationType: AuthorizationType? {
        switch self {
        case .uploadFile(_):
            return .none
        default:
            return .bearer
        }
    }
    
    var baseURL: URL {
        return URL(string: Constants.APISource)!
    }
    
    var path: String {
        switch self {
        case .uploadFile:
            return "/files/upload"
        case .uploadFiles(_):
            return "/files/upload-multiple-files"
        case .delete(_):
            return "/files/delete-multiple-files"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .uploadFile(_):
            return .put
        case .uploadFiles(_):
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
        case .uploadFile(let file):
            let fileData = MultipartFormData(provider: .data(file), name: "data", fileName: "\(Int(Date().timeIntervalSince1970)) \(file.description)", mimeType: "multipart/form-data")
            return .uploadMultipart([fileData])
        case .uploadFiles(let files):
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
        case .uploadFiles(_), .uploadFile(_):
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
