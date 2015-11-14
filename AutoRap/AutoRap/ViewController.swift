//
//  ViewController.swift
//  AutoRap
//
//  Created by Cam on 11/13/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    @IBOutlet var display_: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let welcomeString = "Yo! Give me a word."
        displayLyrics(welcomeString)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func autoRap(sender: AnyObject) {
        // Get the keyword
        var oeGenerator = OELanguageModelGenerator()
        
        // Generate lyrics
        let rapGenerator = RapGenerator()
        let keyword = "Something"
        let lyrics = rapGenerator.generateLyrics(keyword)
        
        // Sythesize voice
        
        // Display lyrics
        displayLyrics(lyrics)
        
        
        
    }
    
    func displayUserInput(input: String){
        display_.text = display_.text + input
    }
    
    func displayLyrics(input: String){
        display_.text = display_.text + input
    }
}

