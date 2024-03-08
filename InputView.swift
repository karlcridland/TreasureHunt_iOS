//
//  InputView.swift
//  Treasure Hunt
//
//  Created by Karl Cridland on 23/02/2024.
//

import Foundation
import UIKit

class InputView: UIView, UITextFieldDelegate{
    
    var boxes: [InputField] = []
    let n: Int = 7
    let gap: CGFloat = 15
    
    var hunter: Hunter?
    
    init(){
        super .init(frame: CGRect(x: 20, y: 220 + self.gap, width: UIScreen.main.bounds.width - 40, height: 60))
        
        let gaps: CGFloat = CGFloat(n - 1) * self.gap
        let width = (self.frame.width - gaps) / CGFloat(self.n)
        
        var previous: InputField?
        
        for _ in 0 ..< self.n{
            let x = (previous != nil) ? previous!.frame.maxX + self.gap - 5 : 0
            let input = InputField(frame: CGRect(x: x, y: 0, width: width + 4, height: 60))
            input.prevField = previous
            input.addTarget(self, action: #selector(didFocus), for: .editingDidBegin)
            input.addTarget(self, action: #selector(didFocus), for: .touchUpInside)
            input.addTarget(self, action: #selector(didType), for: .editingChanged)
            input.delegate = self
            input.text = " "
            
            if ((previous) != nil){
                previous?.nextField = input
            }
            
            self.addSubview(input)
            boxes.append(input)
            previous = input
        }
    }
    
    func suggestCode(){
        if let hunter = self.hunter{
            hunter.suggestCode(self.getLetters())
        }
    }
    
    private func shouldSuggestCode() -> Bool{
        return getLetters().count == 7
    }
    
    private func getLetters() -> String{
        return boxes.map({$0.text ?? ""}).joined()
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        (textField as! InputField).moveCursorToEnd()
    }
    
    @objc func didFocus(_ input: InputField){
        boxes.forEach { box in
            box.isFirstResponder ? box.active() : box.inactive()
        }
        input.moveCursorToEnd()
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
            input.moveCursorToEnd()
        }
    }
    
    @objc func didType(_ input: InputField){
        input.trimText()
        input.text == "" ? input.goToPrevField() : input.goToNextField()
        if (shouldSuggestCode()){
            suggestCode()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let input = textField as? InputField{
            input.goToNextField()
        }
        return true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
