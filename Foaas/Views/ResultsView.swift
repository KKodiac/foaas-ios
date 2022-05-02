//
//  Results.swift
//  Foaas
//
//  Created by Sean Hong on 2022/04/30.
//

import Foundation
import SwiftUI
import SlideOverCard

struct ResultsView: View {
    @ObservedObject var detailOperations: APIServiceDetail
    @ObservedObject var states: AppStates
    
    var body: some View {
        SlideOverCard($states.cardPosition, backgroundStyle: $states.cardBackground) {
            VStack {
                Text(states.tappedContent?.name ?? "")
                    .font(.headline)
                Text("Enter values separated with spaces")
                    .font(.subheadline)
                TextField("\(states.tappedContent?.url?.absoluteString ?? "")", text:$states.fieldValue)
                    .textFieldStyle(.roundedBorder)
                    .padding([.leading, .trailing])
                Button(action: {
                    states.isHidden.toggle()
                    detailOperations.loadDetailOperationObjects(content: states.tappedContent!, object: states.fieldValue)
                }) {
                    Text(states.isHidden ? "Hide" : "Show")
                        .font(.headline)
                        .fontWeight(.bold)
                }
                .buttonStyle(.borderedProminent)
                
                VStack(alignment: .trailing)  {
                    Text(detailOperations.message ?? "")
                        .font(.headline)
                        .textFieldStyle(.roundedBorder)
                        .padding([.top, .bottom])
                    
                    Text(detailOperations.subtitle ?? "")
                        .font(.subheadline)
                        .textFieldStyle(.roundedBorder)
                }
                .opacity(states.isHidden ? 1 : 0)
                
            }
            .padding(.all)
        }
        
    }
}
