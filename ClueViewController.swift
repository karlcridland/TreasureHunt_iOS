//
//  ClueViewController.swift
//  Treasure Hunt
//
//  Created by Karl Cridland on 24/02/2024.
//

import Foundation
import UIKit

class ClueViewController: UIViewController{
    
    @IBOutlet var picture: UIImageView!
    @IBOutlet var clue: UITextView!
    @IBOutlet var barry: UIImageView!
    
    let text: [String: String] = [
        "LSTCEWN": "Hello hooman. I am Barry the Alien. I could use a little help, I've crash landed on your planet and I seem to have lost an important piece of my hyperdrive along the way. I fear it's left a trail of clues. Could you please help me find it?\n\nI heard you hoomans like pancakes for your birthday so please find your next clue at the sweetest place in melton.\n\nAlso. Whatever you do. DO NOT PRESS THE RED BUTTON! Please.",
        "EFSOIIR": "Now that you have enjoyed your delicious fuel source, I think we should get started.\n\nCould you please find my spaceship, I managed to place it down nearby in a big collection of trees.\n\nI must say the trees are awfully quiet, on my planet they're much more chatty.\n\n\n..you haven't pressed the red button have you?",
        "OGITNTS": "I didn't leave the piece with the ship then? The only other place I've been is to the fun machines by very salty water. I don't know how you hoomans drink that stuff.\n\nCould you please go there, have some fun, and keep an eye out for the piece of my hyperdrive.\n\nThank you for not pressing the red button. Every time you do a member of my planet dies. To be honest I'm questioning why I ever installed it on there in the first place.",
        "DYAGEHN": "Not there either?\n\nMaybe back where you started then.\n\nHave you checked your pockets?\n\n..behind your ear, maybe?\n\nHave you checked inside all of your photo frames?",
        "ALLDONE": "Happy birthday Emily. 🎉\n\nI hope you have a wonderful day, enjoy your cake. We don't have birthdays or cake on my planet.\n\n",
        "TWQPESR": "Follow this clue to find your treasure.",
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setUp(_ id: String){
        picture.image = UIImage(named: id)
        barry.image = UIImage(named: "barry-\(id)")
        clue.text = text[id]
        if (id == "ALLDONE"){
            if let t = text[id]{
                clue.text = "\(t)\n\n\(self.getClickText())"
            }
        }
    }
    
    func getClickText() -> String{
        let n = UserDefaults.standard.integer(forKey: "clicks")
        switch (n){
        case 0:
            return "You managed to not press the button once and saved the population of my planet"
        default:
            return "You killed \(n) \(n == 1 ? "person" : "people"). But I forgive you."
        }
    }
    
}
