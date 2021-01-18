//
//  DeviceStatusesList.swift
//  ReguardHub
//
//  Created by Timothy Tong on 1/15/21.
//

import SwiftUI

struct DevicesListView: View {
    @ObservedObject var deviceFetcher: DeviceFetcher
    
    var body: some View {
        List(deviceFetcher.devices) { device in
            DeviceStatusRow(device: device)
        }
    }
}

let deviceData = [device, device, device]

struct DeviceStatusesList_Previews: PreviewProvider {
    static var previews: some View {
        DevicesListView(deviceFetcher: DeviceFetcher())
    }
}
