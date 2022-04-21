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
    let name: String
    let url: URL
    let fields: [Field]
}

struct Field: Codable {
    let name: String
    let field: String
}
