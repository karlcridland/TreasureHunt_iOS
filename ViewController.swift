//
//  ViewController.swift
//  Treasure Hunt
//
//  Created by Karl Cridland on 22/02/2024.
//

import UIKit
//import CoreNFC
import CoreLocation
import CoreMotion


class ViewController: UIViewController, CLLocationManagerDelegate { //NFCNDEFReaderSessionDelegate
    
    static var home: UIViewController?
    
    var triedOnce = false
//    var session: NFCNDEFReaderSession?
    var locationManager = CLLocationManager()
    var motionManager = CMMotionManager()
    
    @IBOutlet var safeView: UIView!
    
    let hunter: Hunter = Hunter()
    let sonar: SonarView = SonarView()
    let inputs: InputView = InputView()
    let clue: ClueButton = ClueButton()
    let red: RedButton = RedButton()
    let printer: Printer = Printer()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ViewController.home = self
        
//        session = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: true)
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.startUpdatingHeading()
        
        motionManager.startDeviceMotionUpdates()
        
        self.sonar.beeper.frame = CGRect(x: -5, y: -5, width: UIScreen.main.bounds.width+10, height: self.safeView.frame.minY+5)
        
        self.safeView.addSubview(self.sonar)
        self.safeView.addSubview(self.inputs)
        self.safeView.addSubview(self.clue)
        self.safeView.addSubview(self.red)
        self.safeView.addSubview(self.printer)
        self.safeView.addSubview(self.printer.print)
        self.safeView.addSubview(self.printer.tare)
        
        self.view.addSubview(self.sonar.beeper)
        
        inputs.hunter = self.hunter
        sonar.hunter = self.hunter
        sonar.printer = self.printer
        hunter.sonar = self.sonar
        clue.hunter = self.hunter
        clue.viewController = self
        
        self.printer.layer.zPosition = 50
        self.printer.ream.layer.zPosition = 100
        self.printer.ream.frame = CGRect(x: self.printer.ream.frame.minX + self.printer.frame.minX, y: self.printer.ream.frame.minY + self.printer.frame.minY, width: self.printer.ream.frame.width, height: self.printer.ream.frame.height)
        self.safeView.addSubview(self.printer.ream)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
            let magneticHeading = newHeading.magneticHeading
            updateCompassUI(magneticHeading: magneticHeading)
        }
    
    func updateCompassUI(magneticHeading: CLLocationDirection) {
        
        let rotationAngle = CGFloat(magneticHeading).degreesToRadians
        hunter.updateRotation(rotationAngle)
        self.updateSonar()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        hunter.updateLocation(latitude, longitude)
        self.updateSonar()
    }
    
    func updateSonar(){
        sonar.updateMarker()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: \(error)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        locationManager.stopUpdatingHeading()
        motionManager.stopDeviceMotionUpdates()
    }
    
    //    @objc func beginSession(){
    //        session = NFCNDEFReaderSession(delegate: self, queue: DispatchQueue.main, invalidateAfterFirstRead: true)
    //        session?.begin()
    //    }
    //
    //    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
    //        return
    //    }
    //
    //    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
    //        print("reading")
    //        for message in messages {
    //            for record in message.records {
    //                if let string = String(data: record.payload, encoding: .ascii)?.replacingOccurrences(of: "\u{02}en", with: "") {
    //                    print(string)
    //                }
    //            }
    //        }
    //    }
    //
    //    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
    //        if (self.triedOnce){
    //            beginSession()
    //            self.triedOnce = true
    //        }
    //        else{
    //            self.triedOnce = false
    //        }
    //    }

}

extension CGFloat {
    var degreesToRadians: CGFloat { return self * .pi / 180 }
    var radiansToDegrees: CGFloat { return self * 180 / .pi }
}
