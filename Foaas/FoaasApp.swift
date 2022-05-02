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
            let appStates = AppStates()
            ContentView(operations: services, detailOperations: detailServices, state: appStates)
        }
    }
}
