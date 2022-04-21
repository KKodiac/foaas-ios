//
//  ContentView.swift
//  Foaas
//
//  Created by Sean Hong on 2022/04/17.
//

import SwiftUI

struct ContentView: View {
    @State private var message: String = ""
    @State private var subtitle: String = ""
    
    var body: some View {
        VStack {
            VStack {
                Text(message)
                    .font(.headline)
                    .padding(.all)
                HStack {
                    Spacer()
                    Text(subtitle)
                        .font(.footnote)
                        .multilineTextAlignment(.trailing)
                        .padding(.all)
                }
            }
            
            .padding(6)
            Spacer()
            Button(action: self.version) {
                Text("Version")
            }
            Divider()
            Button(action:self.absolutely) {
                Text("Absolutely")
            }
            Divider()
            Button(action:self.anyway) {
                Text("Anyway")
            }
            Divider()
            Button(action:self.asshole) {
                Text("Asshole")
            }
        }
    }
    
    func version() {
        APIClient.version { result in
            switch result {
            case .success(let version):
                message = version.message
                subtitle = version.subtitle
                print(version)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func absolutely() {
        APIClient.absolutely(company: "John", from: "Sean") { result in
            switch result {
            case .success(let content):
                message = content.message
                subtitle = content.subtitle
                print(content)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func anyway() {
        APIClient.anyway(company: "John", from: "Sean") { result in
            switch result {
            case .success(let content):
                message = content.message
                subtitle = content.subtitle
                print(content)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func asshole() {
        APIClient.asshole(from: "Sean") { result in
            switch result {
            case .success(let content):
                message = content.message
                subtitle = content.subtitle
                print(content)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
