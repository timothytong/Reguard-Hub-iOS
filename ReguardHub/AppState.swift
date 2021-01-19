//
//  AppState.swift
//  ReguardHub
//
//  Created by Timothy Tong on 1/18/21.
//

import SwiftUI
import Combine

class AppState: ObservableObject {
    
    func reloadHome() {
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.reloadHome()
    }
}
