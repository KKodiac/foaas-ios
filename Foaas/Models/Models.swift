//
//  Models.swift
//  Foaas
//
//  Created by Sean Hong on 2022/04/17.
//

import Foundation

struct Foaas: Codable {
    let message: String
    let subtitle: String
}


struct Operations: Codable {
    var name: String
    var url: URL
    var fields: [Fields]
    
    enum CodingKeys: String, CodingKey {
        case name
        case url
        case fields
    }
}

struct Fields: Codable {
    let name: String?
    let field: String?
}

extension Operations: Identifiable {
    var id: UUID { return UUID() }
}
