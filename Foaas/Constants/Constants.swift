//
//  Constants.swift
//  Foaas
//
//  Created by Sean Hong on 2022/04/18.
//

import Foundation

struct K {
    struct ProductionServer {
        static let baseURL = "https://foaas.com"
//        static let baseURL = "https://foaas-kr.herokuapp.com" // For testing with Korean FOAAS
    }
    
    
}

struct APIParameterKey {
    var objects: [UUID: String] = [UUID:String]()
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}

enum AcceptType: String {
    case json = "application/json"
}
