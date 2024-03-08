//
//  SonarView.swift
//  Treasure Hunt
//
//  Created by Karl Cridland on 23/02/2024.
//

import Foundation
import UIKit

class SonarView: UIView{
    
    var hunter: Hunter?
    var printer: Printer?
    
    private let numberOfBars = 5
    private let numberOfCircles = 3
    private let thickness: CGFloat = 3
    private let color: UIColor = #colorLiteral(red: 0.4500938654, green: 0.9813225865, blue: 0.4743030667, alpha: 1)
    
    private let marker = UILabel()
    private let plate = UIView()

    let beeper = UIView()
    
    let generator = UIImpactFeedbackGenerator()
    var level = 0
    
    init(){
        super .init(frame: CGRect(x: 20, y: 20, width: UIScreen.main.bounds.width - 40, height: 200))
        
        self.backgroundColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        self.clipsToBounds = true
        self.stylize()
        
        self.setBars()
        self.setCircles()
        
        self.beeper.stylize()
        self.beeper.backgroundColor = #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
        
        plate.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.width)
        plate.center = CGPoint(x: self.frame.width/2, y: self.frame.height)
        self.addSubview(plate)
        
        marker.frame = CGRect(x: 0, y: 0, width: 180, height: 30)
        marker.layer.cornerRadius = 5
        marker.textColor = self.color
        marker.font = .systemFont(ofSize: 24, weight: .bold)
        marker.textAlignment = .center
        marker.numberOfLines = 2
        self.marker.isHidden = true
        self.plate.addSubview(marker)
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            switch (self.level){
            case 1:
                self.generator.impactOccurred(intensity: 0.5)
                break
            case 2:
                self.generator.impactOccurred(intensity: 1)
                break
            default:
                break
            }
        }
    }
    
    func updateMarkerText(_ id: String){
        plate.isHidden = true
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            self.marker.text = id
            self.plate.isHidden = false
        }
    }
    
    func updateMarker(){
        if let hunter = hunter, let angle = hunter.getAngle(), let printer = self.printer{
            let r = angle - hunter.rotation
            let d = r.radiansToDegrees
            self.beeper.backgroundColor = (d > -5 && d < 5) ? self.color : #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1)
            
            if (d > -5 && d < 5){
                level = 2
            }
            else if (d > -15 && d < 15){
                level = 1
            }
            else{
                level = 0
            }
            
            if let dist = hunter.getDistance(){
                printer.queueText("Clue is \(Int(dist).getUnit()) away.")
                self.marker.isHidden = false
                marker.center = CGPoint(x: ((self.frame.width)/CGFloat(2)), y: getXPosition(dist) - abs(d))
            }
            
            UIView.animate(withDuration: 0.1) {
                self.plate.transform = CGAffineTransform(rotationAngle: r)
                self.marker.transform = CGAffineTransform(rotationAngle: -r)
            }
        }
    }
    
    func getXPosition(_ distance: CGFloat) -> CGFloat{
        return (self.plate.frame.height/2) - (distance * 5)
    }
    
    func hideMarker(){
        self.marker.isHidden = true
    }
    
    func setCircles(){
        let width = (self.frame.width + 80)/3
        for i in 0 ..< numberOfCircles{
            let size = CGFloat(i+1) * width
            let circle = UIView(frame: CGRect(x: 0, y: 0, width: size, height: size))
            circle.layer.cornerRadius = size/2
            circle.layer.borderWidth = thickness
            circle.layer.borderColor = color.cgColor
            self.addSubview(circle)
            circle.center = CGPoint(x: self.frame.width/2, y: self.frame.height - 2)
        }
    }
    
    func setBars(){
        for i in 0 ..< numberOfBars{
            let bar = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width * 2, height: thickness))
            bar.backgroundColor = self.color
            
            bar.center = CGPoint(x: self.frame.width/2, y: self.frame.height - 2)
            bar.transform = CGAffineTransform(rotationAngle: (CGFloat(i+1) * .pi)/CGFloat(numberOfBars + 1))
            self.addSubview(bar)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Int{
    
    func getUnit() -> String{
        if (self >= 1000){
            return "\(self/1000)km"
        }
        return "\(self)m"
    }
}
