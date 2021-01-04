//
//  Event.swift
//  ReguardHub
//
//  Created by Timothy Tong on 1/17/21.
//

import Foundation

struct Event: Hashable, Decodable {
    var deviceId: String
    var eventTimestamp: String
    var videoUrl: String?
}

struct EventList: Decodable {
    var events: [Event]
}

extension Event: Identifiable {
    var id: Int { return hashValue }
}
