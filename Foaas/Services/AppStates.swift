//
//  AppStates.swift
//  Foaas
//
//  Created by Sean Hong on 2022/04/30.
//

import Foundation
import SlideOverCard


class AppStates: ObservableObject {
    @Published var tappedContent: Operations?
    @Published var fieldValue: String = ""
    @Published var showSearch = false
    @Published var isHidden = false
    @Published var cardPosition = CardPosition.bottom
    @Published var cardBackground = BackgroundStyle.solid
}
