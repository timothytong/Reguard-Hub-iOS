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
            ZStack {
                TabView(selection: $currentTab) {
                    GeometryReader { geometry in
                        RefreshableDevicesScrollView(width: geometry.size.width, height: geometry.size.height)
                    }
                    .tabItem {
                        VStack {
                            Image(systemName: "laptopcomputer.and.iphone")
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
                                Image(systemName: "folder.badge.person.crop")
                                Text("Events")
                            }.onTapGesture { self.currentTab = ReguardHubTab.Events }
                        }
                        .tag(ReguardHubTab.Events)
                }.navigationTitle(currentTab)
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Button(action: {
                            
                        }, label: {
                            Image(systemName: "lock.shield")
                                .font(.system(.largeTitle))
                                .frame(width: 77, height: 76)
                                .foregroundColor(Color.white)
                                .padding(.bottom, 1)
                            
                        })
                        .background(Color.black)
                        .cornerRadius(38.5)
                        .padding()
                        .shadow(color: Color.gray.opacity(0.3), radius: 3, x: 3, y: 3)
                        .overlay(Circle().inset(by: 16).stroke(Color.white, lineWidth: 1))
                        Spacer()
                    }
                }
            }
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
