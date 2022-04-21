//
//  Service.swift
//  Foaas
//
//  Created by Sean Hong on 2022/04/21.
//

import Foundation
import Alamofire

class APIClient {
    static func operations(completion: @escaping (Result<[Operations], AFError>) -> Void) {
        AF.request(APIRouter.operations)
            .responseDecodable { (response: DataResponse<[Operations], AFError>) in
                completion(response.result)
            }
    }
    
    static func version(completion: @escaping (Result<Foaas, AFError>) -> Void) {
        AF.request(APIRouter.version)
            .responseDecodable { (response: DataResponse<Foaas, AFError>) in
                completion(response.result)
            }
    }
    
    static func absolutely(company: String, from: String, completion:@escaping (Result<Foaas, AFError>) -> Void) {
        let jsonDecoder = JSONDecoder()
        AF.request(APIRouter.absolutely(company: company, from: from))
            .responseDecodable(decoder: jsonDecoder) { (response: DataResponse<Foaas, AFError>) in
                completion(response.result)
            }
    }
    
    static func anyway(company: String, from: String, completion:@escaping (Result<Foaas, AFError>) -> Void) {
        AF.request(APIRouter.anyway(company: company, from: from))
            .responseDecodable { (response: DataResponse<Foaas, AFError>) in
                completion(response.result)
            }
    }
    
    static func asshole(from: String, completion:@escaping (Result<Foaas, AFError>) -> Void) {
        AF.request(APIRouter.asshole(from: from))
            .responseDecodable { (response: DataResponse<Foaas, AFError>) in
                completion(response.result)
            }
    }
}
