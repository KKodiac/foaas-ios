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
    }
    
    struct APIParameterKey {
        static let classes = "class"
        static let behavior = "behavior"
        static let language = "language"
        static let thing = "thing"
        static let noun = "noun"
        static let reference = "reference"
        static let something = "something"
        static let doing = "do"
        static let tool = "tool"
        static let company = "company"
        static let name = "name"
        static let from = "from"
    }
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
