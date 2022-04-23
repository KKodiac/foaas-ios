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
        AF.request(BaseAPIRouter.operations)
            .responseDecodable { (response: DataResponse<[Operations], AFError>) in
                completion(response.result)
            }
    }
    
    static func version(completion: @escaping (Result<Foaas, AFError>) -> Void) {
        AF.request(BaseAPIRouter.version)
            .responseDecodable { (response: DataResponse<Foaas, AFError>) in
                completion(response.result)
            }
    }
    
    static func details(of content: Operations, completion: @escaping (Result<Foaas, AFError>) -> Void) {
        AF.request(DetailAPIRouter(content: content))
            .responseDecodable { (response: DataResponse<Foaas, AFError>) in
                completion(response.result)
            }
    }
}
