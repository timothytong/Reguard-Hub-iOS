//
//  DeviceFetcher.swift
//  ReguardHub
//
//  Created by Timothy Tong on 1/15/21.
//

import Foundation
public class DeviceFetcher: ObservableObject {
    @Published var devices = [Device]()
    
    init() {
        getUserDevices()
    }
    
    func getUserDevices() {
        print("Loading user devices..")
        guard let url = URL(string: "http://reguard-backend.eba-fb3wmizg.us-east-1.elasticbeanstalk.com/api/v1/user/devices") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print("Error fetching user devices - \(err)")
            }
            guard let data = data else {
                print("Error - No device data returned")
                return
            }
            
            let devices = try! JSONDecoder().decode(DeviceList.self, from: data)
            DispatchQueue.main.async {
                self.devices = devices.devices
            }
        }.resume()
    }
}
