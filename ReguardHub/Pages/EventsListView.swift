//
//  EventsList.swift
//  ReguardHub
//
//  Created by Timothy Tong on 1/17/21.
//

import SwiftUI

struct EventsListView: View {
    @EnvironmentObject var eventFetcher: EventFetcher
    
    var body: some View {
        List(eventFetcher.events) { event in
            NavigationLink(destination: EventDetailsPageView(event: event)) {
                GuardianEventRow(event: event)
            }
        }
    }
}

struct EventsList_Previews: PreviewProvider {
    static var previews: some View {
        EventsListView().environmentObject(EventFetcher())
    }
}
