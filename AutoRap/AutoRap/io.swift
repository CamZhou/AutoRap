//
//  io.swift
//  AutoRap
//
//  Created by Cam on 11/14/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import Foundation

class fileReader {
    func readFile(fileName: String) -> [String] {
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "txt")
        let text = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: ErrorType.self)
        return text.componentsSeparatedByString(" ")
    }
}