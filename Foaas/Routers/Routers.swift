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
        var pathString = "/\(content.url!.pathComponents[1])"
        content.url!.pathComponents[2...].forEach { path in
            pathString = "\(pathString)/<\(path)>"
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


class DetailObjectAPIRouter: URLRequestConvertible {
    let content: Operations
    let userObjects: String
    init(content: Operations, userObjects: String) {
        self.content = content
        self.userObjects = userObjects
    }
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        return .get
    }
    
    // MARK: - Path
    private var path: String {
        var pathString = "/\(content.url!.pathComponents[1])"
        userObjects.components(separatedBy: " ").forEach { path in
            pathString = "\(pathString)/\(path)"
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
