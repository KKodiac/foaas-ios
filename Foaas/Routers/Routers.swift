//
//  Routers.swift
//  Foaas
//
//  Created by Sean Hong on 2022/04/17.
//

import Foundation
import Alamofire

enum BaseAPIRouter: URLRequestConvertible {
    case version
    case operations
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .operations, .version:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .version:
            return "/version"
        case .operations:
            return "/operations"
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(AcceptType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
       
        return urlRequest
    }
}

class DetailAPIRouter: URLRequestConvertible {
    let content: Operations
    init(content: Operations) {
        self.content = content
    }
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        return .get
    }
    
    // MARK: - Path
    private var path: String {
        var pathString = "/\(content.url.pathComponents[1])"
        content.fields.forEach { field in
            pathString = "\(pathString)/\(String(describing: field.field))"
        }
        return pathString
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(AcceptType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
       
        return urlRequest
    }
}


