//
//  Barry.swift
//  Treasure Hunt
//
//  Created by Karl Cridland on 22/02/2024.
//

import Foundation

class Barry{
    
    private var clues: [Clue] = []
    
    public static let alien = Barry()
    
    private init(){
        clues.append(Clue("TESTING", "TEST", "THE COCK INN", 52.04553286777522, 0.958710701705397))
        clues.append(Clue("LSTCEWN", "EFSOIIR", "HONEY AND HARVEY, MELTON", 52.105067546998185, 1.337681827997361))
        clues.append(Clue("EFSOIIR", "OGITNTS", "UFO IN RENDLESHAM FOREST", 52.08366395120747, 1.433322493966459))
        clues.append(Clue("OGITNTS", "DYAGEHN", "ARCADES IN FELIXTOWE", 51.95825293286456, 1.3469923531321795))
        clues.append(Clue("DYAGEHN", "ALLDONE", "32 ACER ROAD", 52.128472833703256, 1.4158564766373025))
        clues.append(Clue("ALLDONE", "happy birthday", "32 ACER ROAD", 52.128472833703256, 1.4158564766373025))
        clues.append(Clue("TWQPESR", "TREASURE", "32 ACER ROAD", 52.128472833703256, 1.4158564766373025))
    }
    
    func clueIds() -> [String]{
        return self.clues.map({$0.id})
    }
    
    func getClue(_ id: String) -> Clue?{
        if let clue = self.clues.first(where: {$0.id == id}){
            return clue
        }
        return nil
    }
    
    func nextClueID(_ clue: Clue) -> String? {
        return clue.next
    }
    
}
