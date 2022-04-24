//
//  APIServiceDetail.swift
//  Foaas
//
//  Created by Sean Hong on 2022/04/24.
//

import Foundation
import Alamofire

class APIServiceDetail: ObservableObject {
//    @Published var detailsObject: [String]?
    @Published var message: String?
    @Published var subtitle: String?
    
    func loadDetailOperationObjects(content: Operations, object: String) {
        APIClient.detailsObjects(of: content, andObject: object) { result in
            switch result {
            case .success(let detailObject):
                self.message = detailObject.message
                self.subtitle = detailObject.subtitle
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
