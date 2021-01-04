//
//  DeviceStatusRow.swift
//  ReguardHub
//
//  Created by Timothy Tong on 1/14/21.
//

import SwiftUI

struct DeviceStatusRow: View {
    var device: Device
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "iphone")
                Text(device.name)
                Spacer()
                Text(device.status)
            }
            .padding(.leading)
            .padding(.trailing)
            HStack {
                Text(device.location?.replacingOccurrences(of: "@@", with: " - ") ?? "Undefined Location")
                Spacer()
            }
            .padding(.leading)
        }.frame(height: 70)
    }
}

let device = Device(id: "UUID", name: "iPhone X", location: "Home@@Bedroom", status: "GUARDING")

struct DeviceStatusRow_Previews: PreviewProvider {
    static var previews: some View {
        DeviceStatusRow(device: device).previewLayout(.fixed(width: 300, height: 70))
    }
}
