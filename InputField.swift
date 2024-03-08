//
//  InputField.swift
//  Treasure Hunt
//
//  Created by Karl Cridland on 23/02/2024.
//

import Foundation
import UIKit

class InputField: UITextField{
    
    var prevField: InputField?
    var nextField: InputField?
    var hunter: Hunter?
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
        self.textColor = .black
        self.stylize()
        
        self.textAlignment = .center
        self.font = .systemFont(ofSize: 20, weight: .bold)
        self.returnKeyType = .next
        
        self.tintColor = .clear
    }
    
    func trimText(){
        var newText = self.text?.uppercased()
        if let c = newText?.finalLetter{
            newText = c.uppercased()
        }
        self.text = newText
    }
    
    func goToNextField(){
        if let _ = self.nextField?.becomeFirstResponder(){
        }
        else{
            self.resignFirstResponder()
            self.inactive()
        }
    }
    
    func goToPrevField(){
        if let _ = self.prevField?.becomeFirstResponder(){
            self.text = " "
        }
        else{
            self.resignFirstResponder()
            self.inactive()
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        moveCursorToEnd()
        Button.activeElement = self
        return result
    }
    
    func active(){
        UIView.animate(withDuration: 0.2) {
            self.layer.borderColor = UIColor.white.cgColor
        }
    }
    
    func inactive(){
        UIView.animate(withDuration: 0.2) {
            self.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    func moveCursorToEnd() {
        self.selectedTextRange = self.textRange(from: self.endOfDocument, to: self.endOfDocument)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension String {
    var finalLetter: String? {
        guard let lastCharacter = self.last else {
            return nil
        }
        return String(lastCharacter)
    }
}
