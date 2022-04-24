//
//  ContentView.swift
//  Foaas
//
//  Created by Sean Hong on 2022/04/17.
//

import SwiftUI
import SlideOverCard

struct ContentView: View {
    @ObservedObject var operations: APIService
    @ObservedObject var detailOperations: APIServiceDetail
    @State var cardPosition = CardPosition.bottom
    @State var cardBackground = BackgroundStyle.blur
    @State var tappedContent: Operations
    @State var fieldValue = ""
    @State var isHidden = false
    
    
    var body: some View {
        ZStack(alignment: .top) {
            operationBody
            Divider()
            SlideOverCard($cardPosition, backgroundStyle: $cardBackground) {
                resultBody
            }
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
                        tappedContent = op
                        isHidden = false
                        fieldValue = ""
                        cardPosition = CardPosition.middle
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
    
    var resultBody: some View {
        VStack {
//            ForEach(tappedContent.fields) { field in
//                Text("\(field.id)")
//                TextField("\(field.field!)", text:$fieldValue)
//                    .textFieldStyle(.roundedBorder)
//                    .padding([.leading, .trailing])
//            }
            var tappedUrl = tappedContent.url?.absoluteString ?? ""
            TextField("\(tappedUrl)", text:$fieldValue)
                .textFieldStyle(.roundedBorder)
                .padding([.leading, .trailing])
            Button(action: {
                isHidden.toggle()
                detailOperations.loadDetailOperationObjects(content: tappedContent, object: fieldValue)
            }) {
                Text("Show")
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
            .opacity(isHidden ? 1 : 0)
            
        }
        .padding(.all)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let services = APIService()
        let detailServices = APIServiceDetail()
        ContentView(operations: services, detailOperations: detailServices, tappedContent: Operations(name: "", url: nil, fields: [Fields(name: "", field: "")]))
    }
}
