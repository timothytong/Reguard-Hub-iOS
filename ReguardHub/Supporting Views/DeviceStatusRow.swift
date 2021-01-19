//
//  DeviceStatusRow.swift
//  ReguardHub
//
//  Created by Timothy Tong on 1/14/21.
//

import SwiftUI

struct DeviceStatusRow: View {
    var device: Device
    var isOnCheckList: Bool
    var onStatusChange: (Device, Bool) -> Void
    @State private var isChecked: Bool
    
    func toggle() {
        let newIsChecked = !isChecked
        onStatusChange(device, newIsChecked)
        isChecked = newIsChecked
    }
    
    func computeStatusChangeLabel() -> String {
        if (self.device.status == "GUARDING" && !isChecked) {
            return "[-DISARM]"
        }
        if (self.device.status != "GUARDING" && isChecked) {
            return "[+ARM]"
        }
        return ""
    }
    
    var body: some View {
        return HStack {
            if isOnCheckList {
                Image(systemName: isChecked ? "checkmark.square" : "square").offset(x: 10.0, y: 0)
            }
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
                    if isOnCheckList {
                        Text(computeStatusChangeLabel())
                    }
                }
                .padding(.leading)
                .padding(.trailing)
            }.frame(height: 70)
        }.onTapGesture {
            toggle()
        }
    }
}

fileprivate func noopUpdate(device: Device, boolean: Bool) {
    
}

extension DeviceStatusRow {
    
    init(device: Device) {
        self.init(device: device, isOnCheckList: false, onStatusChange: noopUpdate(device:boolean:), isChecked: false)
    }
    
    init (device: Device, isOnCheckList: Bool, onStatusChange: @escaping (Device, Bool) -> Void) {
        if (!isOnCheckList) {
            self.init(device: device)
        } else {
            self.init(device: device, isOnCheckList: true, onStatusChange: onStatusChange, isChecked: device.status == "GUARDING")
        }
    }
}

let guardingDevice = Device(id: "UUID", name: "iPhone X", location: "Home@@Bedroom", status: "GUARDING")
let offlineDevice = Device(id: "UUID2", name: "iPhone SE", location: "Home@@Bedroom", status: "OFFLINE")

struct DeviceStatusRow_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DeviceStatusRow(device: guardingDevice, isOnCheckList: true, onStatusChange: noopUpdate(device:boolean:)).previewLayout(.fixed(width: 300, height: 70))
            DeviceStatusRow(device: offlineDevice, isOnCheckList: true, onStatusChange: noopUpdate(device:boolean:)).previewLayout(.fixed(width: 300, height: 70))
            DeviceStatusRow(device: guardingDevice).previewLayout(.fixed(width: 300, height: 70))
        }
    }
}
