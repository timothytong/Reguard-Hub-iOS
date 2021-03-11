//
//  ContentView.swift
//  ReguardHub
//
//  Created by Timothy Tong on 1/3/21.
//

import SwiftUI
private struct ReguardHubTab {
    static let Devices = "Guardians"
    static let Events = "Events"
}

private struct ReguardHubHomeButton {
    static let ActivateGuardians = "Activate Guardians"
}

struct ContentView: View {
    @State var currentTab = ReguardHubTab.Devices
    @State var btnSelection: String? = nil
    
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
                            Text("Guardians")
                        }.onTapGesture { self.currentTab = ReguardHubTab.Devices }
                    }
                    .tag(ReguardHubTab.Devices)
                    
                    EventsListView()
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
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button("Log Out", action: {
                            AuthSessionManager.shared.logout {
                                DispatchQueue.main.async {
                                    ((UIApplication.shared.connectedScenes.first as! UIWindowScene).delegate as! SceneDelegate).renderRoot()
                                }
                            } onError: { err in
                                
                            }

                        })
                         
                    }
                }
                
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        NavigationLink(destination: ActivateGuardiansPageView(), tag: ReguardHubHomeButton.ActivateGuardians, selection: $btnSelection) {
                            Button(action: {
                                self.btnSelection = ReguardHubHomeButton.ActivateGuardians
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
                        }
                        .isDetailLink(false)
                        Spacer()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let deviceFetcher = GuardianManager.shared
        let eventFetcher = EventFetcher()
        Group {
            ContentView(currentTab: ReguardHubTab.Devices)
            ContentView(currentTab: ReguardHubTab.Events)
        }.environmentObject(deviceFetcher).environmentObject(eventFetcher)
    }
}
