//
//  Clue.swift
//  Treasure Hunt
//
//  Created by Karl Cridland on 22/02/2024.
//

import Foundation
import CoreLocation

class Clue{
    
    let id, text: String
    let next: String?
    let location: CLLocation
    var distance: Double?
    
    init(_ id: String, _ next: String?, _ text: String, _ lat: CLLocationDegrees, _ lon: CLLocationDegrees){
        self.id = id
        self.next = next
        self.text = text
        self.location = CLLocation(latitude: lat, longitude: lon)
    }
    
    func setDistance(){
        
    }
    
}
