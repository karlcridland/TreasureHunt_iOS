//
//  ClueButton.swift
//  Treasure Hunt
//
//  Created by Karl Cridland on 23/02/2024.
//

import Foundation
import UIKit

class ClueButton: Button{
    
    var hunter: Hunter?
    var viewController: ViewController?
    
    override init(frame: CGRect) {
        super .init(frame: CGRect(x: 20, y: 310, width: 140, height: 60))
        self.setTitle("C L U E", for: .normal)
        self.addTarget(self, action: #selector(presentClue), for: .touchUpInside)
    }
    
    @objc func presentClue(){
        if let hunter = self.hunter, let clue = hunter.currentClue, let viewController = self.viewController{
            if let clueController = viewController.storyboard?.instantiateViewController(withIdentifier: "ClueViewController") as? ClueViewController{
                viewController.present(clueController, animated: true){
                    clueController.setUp(clue.id)
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIView{
    
    func stylize(){
        self.layer.cornerRadius = 8
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.borderWidth = 4
    }
    
}

class Button: UIButton{
    
    var colorDown = #colorLiteral(red: 0.5704585314, green: 0.5704723597, blue: 0.5704649091, alpha: 1)
    var colorUp = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
    
    public static var activeElement: InputField?
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        self.stylize()
        self.setTitleColor(.white, for: .normal)
        self.titleLabel?.font = .systemFont(ofSize: 28, weight: .semibold)
        self.backgroundColor = #colorLiteral(red: 0.370555222, green: 0.3705646992, blue: 0.3705595732, alpha: 1)
        self.addTarget(self, action: #selector(down), for: .touchDown)
        self.addTarget(self, action: #selector(up), for: .touchUpInside)
        self.addTarget(self, action: #selector(up), for: .touchUpOutside)
        self.up()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func down(){
        self.setColor(colorDown)
        if let active = Button.activeElement{
            active.resignFirstResponder()
            active.inactive()
        }
    }
    
    @objc private func up(){
        self.setColor(colorUp)
    }
    
    private func setColor(_ color: UIColor){
        UIView.animate(withDuration: 0.2) {
            self.backgroundColor = color
        }
    }
    
}
