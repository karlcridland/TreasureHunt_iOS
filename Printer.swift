//
//  Printer.swift
//  Treasure Hunt
//
//  Created by Karl Cridland on 23/02/2024.
//

import Foundation
import UIKit

class Printer: UIView{
    
    private var isPrinting = false
    
    private let mouth = UIView()
    let ream = UIView()
    
    private var text: String?
    
    let print = Button()
    let tare = Button()
    
    var stack: [Paper] = []
    
    let height: CGFloat = 80
    
    init(){
        let size: CGFloat = UIScreen.main.bounds.width/2
        super .init(frame: CGRect(x: 20, y: 385, width: size, height: 135))
        self.stylize()
        self.backgroundColor = #colorLiteral(red: 0.7540688515, green: 0.7540867925, blue: 0.7540771365, alpha: 1)
        
        mouth.frame = CGRect(x: 30, y: 30, width: size - 60, height: 6)
        mouth.backgroundColor = .black
        mouth.layer.cornerRadius = mouth.frame.height / 2
        self.addSubview(mouth)
        
        self.ream.frame = CGRect(x: self.mouth.frame.minX + 2, y: self.mouth.frame.midY, width: self.mouth.frame.width - 4, height: UIScreen.main.bounds.height)
        self.ream.clipsToBounds = true
        self.layer.zPosition = 100
        
        let x = self.frame.maxX + 15
        let w = UIScreen.main.bounds.width - x - 20
        let h: CGFloat = 60
        
        print.frame = CGRect(x: x, y: self.frame.minY, width: w, height: h)
        tare.frame = CGRect(x: x, y: print.frame.maxY+15, width: w, height: h)
        
        print.setTitle("P R I N T", for: .normal)
        tare.setTitle("T A R E", for: .normal)
        
        print.addTarget(self, action: #selector(printText), for: .touchUpInside)
        tare.addTarget(self, action: #selector(cutPaper), for: .touchUpInside)
    }
    
    func queueText(_ text: String){
        self.text = text
    }
    
    @objc func printText(){
        if (!self.isPrinting){
            self.isPrinting = true
            let paper = Paper(self.text, self.ream, self.height)
            self.stack.append(paper)
            self.ream.addSubview(paper)
            self.resizeStack()
        }
    }
    
    @objc func cutPaper(){
        UIView.animate(withDuration: 1.4) {
            self.stack.forEach { label in
                label.alpha = 0
            }
        }
        UIView.animate(withDuration: 1) {
            self.stack.forEach { label in
                label.transform = CGAffineTransform(translationX: 0, y: UIScreen.main.bounds.height)
            }
        } completion: { _ in
            self.emptyStack()
        }

    }
    
    func resizeStack(){
        UIView.animate(withDuration: 0.5) {
            self.stack.reversed().enumerated().forEach { (i, label) in
                label.frame = CGRect(x: 0, y: CGFloat(i) * self.height, width: self.ream.frame.width, height: self.height)
            }
        } completion: { _ in
            self.isPrinting = false
        }
    }
    
    func emptyStack(){
        let _ = stack.map({$0.removeFromSuperview()})
        stack = []
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Paper: UIView{
    
    let label: UILabel = UILabel()
    
    init(_ text: String?, _ ream: UIView, _ height: CGFloat) {
        super.init(frame: CGRect(x: 0, y: -height, width: ream.frame.width, height: height))
        self.label.text = (text ?? "Please enter a valid code.").uppercased()
        self.label.frame = CGRect(x: 5, y: 0, width: self.frame.width - 10, height: height)
    
        self.label.numberOfLines = 3
        self.backgroundColor = .white
        self.label.font = .systemFont(ofSize: 14, weight: .black)
        self.addSubview(self.label)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
