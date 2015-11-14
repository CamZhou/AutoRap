//
//  io.swift
//  AutoRap
//
//  Created by Cam on 11/14/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import Foundation

class fileReader {
    func readMultipleFiles(i: Int) -> String {
        return readFile("MARKOV/DT_00")
    }
    
    func readFile(fileName: String) -> String {
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "txt")
        do {
            let text = try NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
            return text as String
        }
        catch {/* error handling here */}
        return "No such file exists"
    }
}