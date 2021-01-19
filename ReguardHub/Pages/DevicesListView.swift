//
//  DeviceStatusesList.swift
//  ReguardHub
//
//  Created by Timothy Tong on 1/15/21.
//

import SwiftUI

struct DevicesListView: View {
    @EnvironmentObject var deviceFetcher: GuardianManager
    
    var body: some View {
        List(deviceFetcher.devices) { device in
            DeviceStatusRow(device: device)
        }
    }
}

let deviceData = [guardingDevice, guardingDevice, guardingDevice]

struct DeviceStatusesList_Previews: PreviewProvider {
    static var previews: some View {
        DevicesListView().environmentObject(GuardianManager())
    }
}
