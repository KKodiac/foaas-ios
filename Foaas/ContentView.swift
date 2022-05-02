//
//  ContentView.swift
//  Foaas
//
//  Created by Sean Hong on 2022/04/17.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var operations: APIService
    @ObservedObject var detailOperations: APIServiceDetail
    @ObservedObject var state: AppStates
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                OperationsView(operations: operations, states: state)
                    .searchable(text: $operations.searchText, placement: .sidebar)
                    .onSubmit(of: .search) {
                        operations.isProperSearch = true
                        operations.submitCurrentSearchQuery()
                    }
                ResultsView(detailOperations: detailOperations, states: state)
            }
        }
        .onAppear {
            operations.loadOperations()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let services = APIService()
        let detailServices = APIServiceDetail()
        let appStates = AppStates()
        ContentView(operations: services, detailOperations: detailServices, state: appStates)
    }
}
