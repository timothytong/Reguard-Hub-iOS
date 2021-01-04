//
//  NoNavUiHostingController.swift
//  ReguardHub
//
//  Created by Timothy Tong on 1/16/21.
//

import Foundation
import UIKit
import SwiftUI

public class NoNavUIHostingController<Content>: UIHostingController<AnyView> where Content: View {
    public init(rootView: Content) {
        super.init(rootView: AnyView(rootView.navigationBarHidden(true)))
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
