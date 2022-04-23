//
//  ContentView.swift
//  Foaas
//
//  Created by Sean Hong on 2022/04/17.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var operations: APIService
    
    var body: some View {
        VStack() {
            operationBody
            Divider()
            resultBody
        }
        .onAppear {
            operations.loadOperations()
        }
    }
    
    var operationBody: some View {
        ScrollView {
            VStack {
                ForEach(operations.operations) { op in
                    Button(action: {
                        operations.loadDetailOperations(content: op)
                    }) {
                        VStack {
                            Text("Name: \(op.name)")
                                .foregroundColor(Color.black)
                                .font(.headline)
                            Text("URL: \(op.url)")
                                .foregroundColor(Color.gray)
                                .font(.subheadline)
                            Divider()
                        }
                    }
                }
            }
        }
    }
        
    var resultBody: some View {
        VStack(alignment: .trailing) {
            Text(operations.message)
                .font(.headline)
                .textFieldStyle(.roundedBorder)
                .padding(.bottom)
            
            Text(operations.subtitle)
                .font(.subheadline)
                .textFieldStyle(.roundedBorder)
        }
        .padding(.all)
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let services = APIService()
        ContentView(operations: services)
    }
}
