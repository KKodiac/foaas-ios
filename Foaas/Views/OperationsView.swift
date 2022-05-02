//
//  OperationsView.swift
//  Foaas
//
//  Created by Sean Hong on 2022/04/30.
//

import Foundation
import SlideOverCard
import SwiftUI

struct OperationsView: View {    
    @ObservedObject var operations: APIService
    @ObservedObject var states: AppStates
    
    @Environment(\.isSearching) private var isSearching
    
    var body: some View {
        if !operations.isAllOperationsLoaded {
            ProgressView()
        }
        if isSearching {
            // MARK: Search Result
            Button(action: {
                states.tappedContent = operations.searchedOperation
                states.isHidden = false
                states.fieldValue = ""
                states.cardPosition = CardPosition.middle
                operations.loadDetailOperations(content:operations.searchedOperation)
            }) {
                VStack {
                    Text(operations.searchedOperation.name)
                        .foregroundColor(Color.black)
                        .font(.headline)
                    Text("\(operations.searchedOperation.url!)")
                        .foregroundColor(Color.gray)
                        .font(.subheadline)
                        .opacity(operations.isProperSearch ? 1 : 0)
                }
            }
            .disabled(!operations.isProperSearch)
            .onAppear{
                operations.searchedOperation.name = "Please Enter a Search"
                operations.isProperSearch = false
            }
        } else {
            // MARK: /Operations Result
            ScrollView {
                VStack {
                    ForEach(operations.operations) { op in
                        Button(action: {
                            states.tappedContent = op
                            states.isHidden = false
                            states.fieldValue = ""
                            states.cardPosition = CardPosition.middle
                            operations.loadDetailOperations(content: op)
                        }) {
                            VStack {
                                Text("\(op.name)")
                                    .foregroundColor(Color.black)
                                    .font(.headline)
                                Text("\(op.url!)")
                                    .foregroundColor(Color.gray)
                                    .font(.subheadline)
                                Divider()
                            }
                        }
                    }
                }
            }
        }
    }
}
