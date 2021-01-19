//
//  GuardianEventRow.swift
//  ReguardHub
//
//  Created by Timothy Tong on 1/17/21.
//

import SwiftUI
import Foundation

struct GuardianEventRow: View {
    private let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()
    
    var event: Event
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "clock")
                let date = Date(timeIntervalSince1970: TimeInterval(Int(event.eventTimestamp)! / 1000))
                Text(formatter.string(from: date))
                
                Spacer()
                if event.videoUrl != nil {
                    Image(systemName: "video")
                } else {
                    Image(systemName: "questionmark")
                }
            }
            .padding(.leading)
            .padding(.trailing)
        }.frame(height: 50)
    }
}

let event = Event(deviceId: UUID().uuidString, eventTimestamp: "1610339238871", videoUrl: "https://guardian-event-captures.s3.amazonaws.com/users/user/events/1610339238871%40%4059C7BC3A-77B2-4A3A-8EF5-D1136651EF49.mp4")

struct GuardianEventRow_Previews: PreviewProvider {
    static var previews: some View {
        GuardianEventRow(event: event).previewLayout(.fixed(width: 300, height: 50))
    }
}
