//
//  RedButton.swift
//  Treasure Hunt
//
//  Created by Karl Cridland on 23/02/2024.
//

import Foundation
import UIKit

class RedButton: Button{
    
    var clickCount = 0
    
    override init(frame: CGRect) {
        super .init(frame: CGRect(x: 175, y: 310, width: UIScreen.main.bounds.width - 195, height: 60))
        self.stylize()
        self.backgroundColor = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        self.colorUp = #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)
        self.colorDown = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        
        self.clickCount = UserDefaults.standard.integer(forKey: "clicks")
        self.addTarget(self, action: #selector(clicked), for: .touchUpInside)
    }
    
    @objc func clicked(){
        self.clickCount += 1
        UserDefaults.standard.setValue(self.clickCount, forKey: "clicks")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
