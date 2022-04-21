//
//  Routers.swift
//  Foaas
//
//  Created by Sean Hong on 2022/04/17.
//

import Alamofire
import Foundation

enum APIRouter: URLRequestConvertible {
    case version
    case operations
    case absolutely(company: String, from: String)
    case anyway(company: String, from: String)
    case asshole(from: String)
    
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .version, .operations, .absolutely, .anyway, .asshole:
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
        case .absolutely(let company, let from):
            return "/absolutely/\(company)/\(from)"
        case .anyway(let company, let from):
            return "/anyway/\(company)/\(from)"
        case .asshole(let from):
            return "/asshole/\(from)"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
        case .absolutely(let company, let from):
            return [K.APIParameterKey.company: company, K.APIParameterKey.from: from]
        case .anyway(let company, let from):
            return [K.APIParameterKey.company: company, K.APIParameterKey.from: from]
        case .asshole(let from):
            return [K.APIParameterKey.from: from]
        case .version, .operations:
            return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try K.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
    
        // Parameters
        // Foaas API does not allow GET requests with Bodies
//        if let parameters = parameters {
//            do {
//                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
//            } catch {
//                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
//            }
//        }
        
        return urlRequest
    }
}
