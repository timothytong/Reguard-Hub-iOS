//
//  RefreshScrollView.swift
//  ReguardHub
//
//  Created by Timothy Tong on 1/15/21.
//

import UIKit
import SwiftUI
import Foundation

struct RefreshableDevicesScrollView: UIViewRepresentable {
    var width: CGFloat
    var height: CGFloat
    @EnvironmentObject var deviceFetcher: GuardianManager
    
    func makeUIView(context: Context) -> UIView {
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        let scrollView = UIScrollView()
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(context.coordinator, action: #selector(Coordinator.handleRefreshControl(sender:)), for: .valueChanged)
        
        let refreshVC = UIHostingController(rootView: DevicesListView())
        refreshVC.view.frame = frame
        scrollView.addSubview(refreshVC.view)
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, deviceFetcher: deviceFetcher)
    }
    
    class Coordinator: NSObject {
        var refreshScrollView: RefreshableDevicesScrollView
        var deviceFetcher: GuardianManager
        
        init(_ refreshScrollView: RefreshableDevicesScrollView, deviceFetcher: GuardianManager) {
            self.refreshScrollView = refreshScrollView
            self.deviceFetcher = deviceFetcher
        }
        
        @objc func handleRefreshControl(sender: UIRefreshControl) {
            self.deviceFetcher.getUserDevices(userId: AuthSessionManager.shared.currentUser!.userId)
            sender.endRefreshing()
        }
    }
}
