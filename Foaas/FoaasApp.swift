//
//  FoaasApp.swift
//  Foaas
//
//  Created by Sean Hong on 2022/04/17.
//

import SwiftUI

@main
struct FoaasApp: App {
    var body: some Scene {
        WindowGroup {
            let services = APIService()
            let detailServices = APIServiceDetail()
            ContentView(operations: services, detailOperations: detailServices, tappedContent: Operations(name: "", url: nil, fields: [Fields(name: "", field: "")]))
        }
    }
}
