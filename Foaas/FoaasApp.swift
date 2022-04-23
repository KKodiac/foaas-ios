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
            ContentView(operations: services)
        }
    }
}
