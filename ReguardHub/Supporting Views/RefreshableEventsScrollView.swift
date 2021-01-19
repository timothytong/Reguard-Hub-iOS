//
//  RefreshableEventsScrollView.swift
//  ReguardHub
//
//  Created by Timothy Tong on 1/17/21.
//

import UIKit
import SwiftUI
import Foundation

struct RefreshableEventsScrollView: UIViewRepresentable {
    var width: CGFloat
    var height: CGFloat
    @EnvironmentObject var eventFetcher: EventFetcher
    
    func makeUIView(context: Context) -> UIView {
        let frame = CGRect(x: 0, y: 0, width: width, height: height)
        
        let scrollView = UIScrollView()
        scrollView.refreshControl = UIRefreshControl()
        scrollView.refreshControl?.addTarget(context.coordinator, action: #selector(Coordinator.handleRefreshControl(sender:)), for: .valueChanged)
        
        let refreshVC = UIHostingController(rootView: EventsListView())
        refreshVC.view.frame = frame
        scrollView.addSubview(refreshVC.view)
        
        return scrollView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, eventFetcher: eventFetcher)
    }
    
    class Coordinator: NSObject {
        var refreshScrollView: RefreshableEventsScrollView
        var eventFetcher: EventFetcher
        
        init(_ refreshScrollView: RefreshableEventsScrollView, eventFetcher: EventFetcher) {
            self.refreshScrollView = refreshScrollView
            self.eventFetcher = eventFetcher
        }
        
        @objc func handleRefreshControl(sender: UIRefreshControl) {
            self.eventFetcher.getUserEvents()
            sender.endRefreshing()
        }
    }
}
