//
//  EventFetcher.swift
//  ReguardHub
//
//  Created by Timothy Tong on 1/17/21.
//

import Foundation
public class EventFetcher: ObservableObject {
    @Published var events = [Event]()
    
    init() {
        getUserEvents()
    }
    
    func getUserEvents() {
        print("Loading user events..")
        guard let url = URL(string: "http://reguard-backend.eba-fb3wmizg.us-east-1.elasticbeanstalk.com/api/v1/user/events") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print("Error fetching user events - \(err)")
            }
            guard let data = data else {
                print("Error - No event data returned")
                return
            }
            
            let events = try! JSONDecoder().decode(EventList.self, from: data)
            print("Got \(events)")
            DispatchQueue.main.async {
                self.events = events.events
            }
        }.resume()
    }
}
