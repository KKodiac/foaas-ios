//
//  FoaasAPIService.swift
//  Foaas
//
//  Created by Sean Hong on 2022/04/17.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameters: Parameters? { get }
}

enum APIEndPoint: APIConfiguration {
    case version
    case operations
    case absolutely(company: String, from: String)

    // MARK: - HTTPMethod
    var method: HTTPMethod {
        switch self {
        case .version, .operations, .absolutely:
            return .get
        }
    }
    
    // MARK: - Path
    var path: String {
        switch self {
        case .version:
            return "/version"
        case .operations:
            return "/operations"
        case .absolutely(let company, let from):
            return "/profile/\(company)/\(from)"
        }
    }
    
    // MARK: - Parameters
    var parameters: Parameters? {
        switch self {
        case .absolutely(let company, let from):
            return [K.APIParameterKey.company: company, K.APIParameterKey.from: from]
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
        if let parameters = parameters {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}

