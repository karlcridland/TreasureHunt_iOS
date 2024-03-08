//
//  Hunter.swift
//  Treasure Hunt
//
//  Created by Karl Cridland on 22/02/2024.
//

import Foundation
import UIKit
import CoreLocation

class Hunter{
    
    var location: CLLocation?
    var rotation: CGFloat = 0
    
    var currentClue: Clue?
    
    var sonar: SonarView?
    
    init(){}
    
    func updateLocation(_ lat: CLLocationDegrees, _ lon: CLLocationDegrees){
        self.location = CLLocation(latitude: lat, longitude: lon)
    }
    
    func updateRotation(_ rot: CGFloat){
        self.rotation = rot
    }
    
    func getAngle() -> Double?{
        if let clue = self.currentClue{
            return self.location?.calculateBearing(clue.location.coordinate)
        }
        return nil
    }
    
    func getDistance() -> CGFloat?{
        if let location = self.location, let clue = self.currentClue{
            return CGFloat(clue.location.distance(from: location))
        }
        return nil
    }
    
    func suggestCode(_ code: String){
        if let sonar = self.sonar{
            if (Barry.alien.clueIds().contains(code)){
                currentClue = Barry.alien.getClue(code)
                if let id = currentClue?.next{
                    sonar.updateMarkerText(id)
                }
            }
            else{
                sonar.hideMarker()
            }
        }
    }
    
}

extension CLLocation{
    
    func calculateBearing(_ coordinate: CLLocationCoordinate2D) -> Double {
        let lat1 = self.coordinate.latitude.degreesToRadians
        let lon1 = self.coordinate.longitude.degreesToRadians
        let lat2 = coordinate.latitude.degreesToRadians
        let lon2 = coordinate.longitude.degreesToRadians

        let dLon = lon2 - lon1

        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)

        var angle = atan2(y, x).radiansToDegrees
        if angle < 0 {
            angle += 360.0
        }
        return angle.degreesToRadians
    }
}

extension Double {
    var degreesToRadians: Double { return self * .pi / 180.0 }
    var radiansToDegrees: Double { return self * 180.0 / .pi }
}
