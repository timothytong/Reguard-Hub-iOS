//
//  Device.swift
//  ReguardHub
//
//  Created by Timothy Tong on 1/14/21.
//

import Foundation

struct Device: Hashable, Decodable, Identifiable {
    var id: String
    var name: String
    var location: String?
    var status: String
}

struct DeviceList: Decodable {
    var devices: [Device]
}
