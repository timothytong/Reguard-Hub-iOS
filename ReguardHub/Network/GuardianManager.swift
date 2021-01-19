//
//  DeviceFetcher.swift
//  ReguardHub
//
//  Created by Timothy Tong on 1/15/21.
//

import Foundation

fileprivate struct SessionChangeRequestModel: Codable {
    var userId: String
    var deviceIds: [String]
}

public class GuardianManager: ObservableObject {
    @Published var devices = [Device]()
    private let encoder = JSONEncoder()
    
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
                print("Setting self devices to \(devices.devices)")
                self.devices = devices.devices
            }
        }.resume()
    }
    
    func startSessionForDevices(userId: String, deviceIds: [String]) {
        if (deviceIds.isEmpty) {
            return
        }
        guard let url = URL(string: "http://reguard-backend.eba-fb3wmizg.us-east-1.elasticbeanstalk.com/api/v1/session/start") else { return }
        // guard let url = URL(string: "http://localhost:3000/api/v1/session/start") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters = SessionChangeRequestModel(userId: userId, deviceIds: deviceIds)
        do {
            let data = try encoder.encode(parameters)
            request.httpBody = data
        } catch {
            print("Error encoding JSON.. \(error)")
        }
        standardPost(request: request)
    }
    
    func endSessionForDevices(userId: String, deviceIds: [String]) {
        if (deviceIds.isEmpty) {
            return
        }
        guard let url = URL(string: "http://reguard-backend.eba-fb3wmizg.us-east-1.elasticbeanstalk.com/api/v1/session/end") else { return }
        // guard let url = URL(string: "http://localhost:3000/api/v1/session/end") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let parameters = SessionChangeRequestModel(userId: userId, deviceIds: deviceIds)
        do {
            let data = try encoder.encode(parameters)
            request.httpBody = data
        } catch {
            print("Error encoding JSON.. \(error)")
        }
        standardPost(request: request)
    }
    
    private func standardPost(request: URLRequest) {
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                  let response = response as? HTTPURLResponse,
                  error == nil else {                                              // check for fundamental networking error
                print("error", error ?? "Unknown error")
                return
            }
            
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }.resume()
    }
}
