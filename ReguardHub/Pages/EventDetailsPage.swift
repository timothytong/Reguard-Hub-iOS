//
//  EventDetailsPage.swift
//  ReguardHub
//
//  Created by Timothy Tong on 1/17/21.
//

import SwiftUI
import AVKit

struct EventDetailsPage: View {
    private let formatter: RelativeDateTimeFormatter = {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        return formatter
    }()
    
    var event: Event
    
    var body: some View {
        let date = Date(timeIntervalSince1970: TimeInterval(Int(event.eventTimestamp)! / 1000))
        let title = formatter.localizedString(for: date, relativeTo: Date())
        VStack {
            Text(title).font(.title).fontWeight(.bold)
            if let url = event.videoUrl {
                VideoPlayer(player: AVPlayer(url: URL(string: url)!))
            } else {
                Spacer()
                Text("Capture data unavailable.")
            }
            Spacer()
            Text("Timestamp: \(date)")
        }
    }
}

private let eventNoUrl = Event(deviceId: UUID().uuidString, eventTimestamp: "1", videoUrl: nil)

struct EventDetailsPage_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            EventDetailsPage(event: event)
            EventDetailsPage(event: eventNoUrl)
        }
    }
}
