//
//  ContentView.swift
//  ReguardHub
//
//  Created by Timothy Tong on 1/3/21.
//

import SwiftUI
private struct ReguardHubTab {
    static let Devices = "Your Devices"
    static let Events = "Events"
}

struct ContentView: View {
    
    @State var currentTab = ReguardHubTab.Devices
    
    var body: some View {
        NavigationView {
            TabView(selection: $currentTab) {
                GeometryReader { geometry in
                    RefreshableDevicesScrollView(width: geometry.size.width, height: geometry.size.height)
                }
                .tabItem {
                    VStack {
                        Image(systemName: "star")
                        Text("Devices")
                    }.onTapGesture { self.currentTab = ReguardHubTab.Devices }
                }
                .tag(ReguardHubTab.Devices)
                
                EventsList(eventFetcher: EventFetcher())
                    /*
                     GeometryReader { geometry in
                     RefreshableEventsScrollView(width: geometry.size.width, height: geometry.size.height)
                     }
                     .navigationTitle("Events")
                     */
                    .tabItem {
                        VStack {
                            Image(systemName: "star")
                            Text("Events")
                        }.onTapGesture { self.currentTab = ReguardHubTab.Events }
                    }
                    .tag(ReguardHubTab.Events)
            }.navigationTitle(currentTab)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView(currentTab: ReguardHubTab.Devices)
            ContentView(currentTab: ReguardHubTab.Events)
        }
    }
}
