//
//  RapGenerator.swift
//  AutoRap
//
//  Created by Cam on 11/13/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import Foundation

class RapGenerator {
    let FR = fileReader()
    init() {
        
    }
    
    func generateDictionary(str: String, i: Int) {
        
    }
    
    func generateLyrics(keyword: String) -> String {
        var fileName = "MARKOV/"
        let index = Int(arc4random_uniform(UInt32(56)))
        var tempStr = String(index)
        if index < 10 {
            tempStr = "0" + tempStr
        }
        switch keyword {
        case "Donald Trump":
            fileName += "DT_"
            fileName += tempStr
        case "Eminem":
            fileName += "EM_"
            fileName += tempStr
        case "JAY-Z":
            fileName += "JZ_"
            fileName += tempStr
        case "Notorious":
            fileName += "NB_"
            fileName += tempStr
        case "Shakespeare":
            fileName += "SS_"
            fileName += tempStr
        default:
            fileName += "DT_00"
        }
        return FR.readFile(fileName)
    }
    
}