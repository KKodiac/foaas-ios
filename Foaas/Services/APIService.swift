//
//  Service.swift
//  Foaas
//
//  Created by Sean Hong on 2022/04/24.
//

import Foundation
import Alamofire

class APIService: ObservableObject {
    @Published var operations: [Operations] = [Operations]()
    @Published var message: String = ""
    @Published var subtitle: String = ""
    
    func loadOperations() {
        APIClient.operations { result in
            switch result {
            case .success(let operations):
                self.operations = operations
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func loadDetailOperations(content: Operations) {
        APIClient.details(of: content) { result in
            switch result {
            case .success(let details):
                self.message = details.message
                self.subtitle = details.subtitle
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func version() {
        APIClient.version { result in
            switch result {
            case .success(let version):
                self.message = version.message
                self.subtitle = version.subtitle
                print(version)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
