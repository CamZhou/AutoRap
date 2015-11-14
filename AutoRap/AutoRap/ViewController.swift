//
//  ViewController.swift
//  AutoRap
//
//  Created by Cam on 11/13/15.
//  Copyright © 2015 Cameric. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    @IBOutlet var display_: UITextView!
    let synth = AVSpeechSynthesizer()
    var myUtterance = AVSpeechUtterance(string: "")
    var rapGenerator = RapGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        display_.editable = false;
        display_.scrollEnabled = true;
        
        let welcomeString = "Yo! Give me a word."
        displayLyrics(welcomeString)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func autoRapWithVoice(sender: UIButton) {
        let keyword = "hahhahahahahahah haha hahahahaha"
        autoRap(keyword)
    }
    @IBAction func autoRapWithTopic(sender: UIButton) {
        let keyword = sender.accessibilityIdentifier
        autoRap(keyword!)
    }
    
    func autoRap(keyword: String) {
        // Generate lyrics
        let lyrics = rapGenerator.generateLyrics(keyword)
        
        // Sythesize voice
        myUtterance = AVSpeechUtterance(string: lyrics)
        configUtterance()
        synth.speakUtterance(myUtterance)
        
        // Display lyrics
        displayLyrics(lyrics)
    }
    
    func configUtterance() {
        myUtterance.pitchMultiplier = 0.5 + Float(drand48()) * 1.5
        myUtterance.rate = AVSpeechUtteranceMinimumSpeechRate + Float(drand48()) * AVSpeechUtteranceMaximumSpeechRate
        myUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
    }
    
    func displayUserInput(input: String){
        display_.text = display_.text + input
    }
    
    func displayLyrics(input: String){
        display_.text = display_.text + input
    }
}

