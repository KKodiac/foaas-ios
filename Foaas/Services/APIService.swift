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
    @Published var searchText: String = ""
    @Published var isProperSearch = false
    @Published var isOperationFound = false
    @Published var isAllOperationsLoaded = false
    @Published var searchedOperation: Operations = Operations(name: "Please Enter a Search", url: URL(string: "/"), fields: [Fields(name: "", field: "")])
    
    
    // MARK: FOAAS API 의 호출 가능한 전체 API 루트 호출
    func loadOperations() {
        APIClient.operations { result in
            switch result {
            case .success(let operations):
                self.operations = operations
                self.isAllOperationsLoaded.toggle()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: FOAAS API 의 호출 가능한 특정 API 루트 호출
    func loadDetailOperations(content: Operations) {
        APIClient.details(of: content) { result in
            switch result {
            case .success(let details):
                self.message = details.message
                self.subtitle = details.subtitle
                self.isProperSearch = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: FOAAS API 버전 호출
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
    
    // MARK: 현재 Searchable Text에 대한 쿼리 요청
    func submitCurrentSearchQuery() {
        if operations.isEmpty {
            isAllOperationsLoaded.toggle()
            loadOperations()
        } else {
            operations.forEach { operation in
                if searchText.lowercased() == operation.url?.pathComponents[1] {
                    searchedOperation = operation
                    isOperationFound = true
                } 
            }
        }
        
    }
}
