//
//  GuardianControlChangeModel.swift
//  ReguardHub
//
//  Created by Timothy Tong on 1/17/21.
//

import Foundation

struct GuardianControlChange: CustomStringConvertible {
    var devicesToArm: Set<Device> = Set()
    var devicesToDisarm: Set<Device> = Set()
    
    var description: String {
        return "Devices to arm: \(devicesToArm);\nDevices to disarm: \(devicesToDisarm)"
    }
}
