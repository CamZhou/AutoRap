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
    var audioPlayer = AVAudioPlayer()
    
    var rateMultiplier = 0.5
    
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
        let keyword = "Fernando is a song by the Swedish pop group ABBA. It was the group's first non-album single and was released in March 1976 through Polar Music. Solo parts were sung by Anni-Frid Lyngstad. The track was featured on the 1976 compilation album Greatest Hits in some countries, although in Australia and New Zealand, Fernando was included on the group's fourth studio album Arrival. Fernando is also featured on the multi-million selling Gold: Greatest Hits compilation. The song was to become ABBA's best-selling single of all time, with 6,000,000 copies sold in 1976 alone.[1] It is one of less than forty all-time singles to have sold 10 million (or more) physical copies worldwide."
        autoRap(keyword)
    }
    
    @IBAction func autoRapWithTopic(sender: UIButton) {
        let keyword = sender.accessibilityIdentifier
        autoRap(keyword!)
    }
    
    func autoRap(keyword: String) {
        // Generate lyrics
        let lyrics = rapGenerator.generateLyrics(keyword)
        
        // Display lyrics
        displayLyrics(lyrics)
        playBeats()
        
        for char in lyrics.componentsSeparatedByString(" ") {
            // Sythesize voice
            myUtterance = AVSpeechUtterance(string: char)
            configUtterance()
            synth.speakUtterance(myUtterance)
            
        }
        
    }
    
    @IBAction func playBeats() {
        let beatsNames = ["Loops/Drummer1", "Loops/Drummer2", "Loops/Drummer3", "Loops/Drummer4", "Loops/Drummer5", "Loops/Drummer6", "Loops/Drummer7"]
        let beats = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource(beatsNames[Int(drand48()*Double(beatsNames.count))], ofType: "wav")!)
        do {
            try audioPlayer = AVAudioPlayer(contentsOfURL: beats)
        } catch {
            // Handle the error
        }
        audioPlayer.numberOfLoops = -1
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    func configUtterance() {
        myUtterance.postUtteranceDelay = 0.0
        myUtterance.preUtteranceDelay = 0.0
        myUtterance.pitchMultiplier = 0.5 + Float(drand48()) * 1.5
        myUtterance.rate = AVSpeechUtteranceMinimumSpeechRate + AVSpeechUtteranceMaximumSpeechRate - AVSpeechUtteranceMinimumSpeechRate * Float(rateMultiplier)
        myUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
    }
    
    func displayUserInput(input: String){
        display_.text = display_.text + "\n" + input
    }
    
    func displayLyrics(input: String){
        display_.text = display_.text + "\n" + input
    }
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
    }
}


