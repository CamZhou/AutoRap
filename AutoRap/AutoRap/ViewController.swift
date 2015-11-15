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
    
//    var nextRate = AVSpeechUtteranceDefaultSpeechRate
//    var nextPitch = Float(1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        display_.editable = false;
        display_.scrollEnabled = true;
        
        let welcomeString = "Let's rap."
        displayLyrics(welcomeString)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func fun(sender: UIButton) {
        synth.stopSpeakingAtBoundary(AVSpeechBoundary(rawValue: 0)!)
        let ha = "Hahahahahahahahahahaha hahahahahahahahahahahahahahahahahahahaha Hahahahahaha Hahaha haha ha hahahaha Ha Hehe"
        for word in ha.componentsSeparatedByString(" ") {
            myUtterance = AVSpeechUtterance(string: word)
            configUtterance()
            synth.speakUtterance(myUtterance)
        }
    }
    
    @IBAction func autoRapWithTopic(sender: UIButton) {
        let keyword = sender.currentTitle
        autoRap(keyword!)
    }
    
    func autoRap(keyword: String) {
        
        // Generate lyrics
        let lyrics = rapGenerator.generateLyrics(keyword)
        
        // Display lyrics
        displayLyrics(lyrics)
        synth.stopSpeakingAtBoundary(AVSpeechBoundary(rawValue: 0)!)
        playBeats()
        
        var str = ""
        for word in lyrics.componentsSeparatedByString(" ") {
            str += word
            let lastChar = word.characters.last
            if lastChar == "." || lastChar == "," || lastChar == "?" || lastChar == "!" || lastChar == ";" {
                // Sythesize voice
                myUtterance = AVSpeechUtterance(string: str)
                str = ""
                configUtterance()
                synth.speakUtterance(myUtterance)
            }
        }
    }
    
    func configUtterance() {
        myUtterance.postUtteranceDelay = 0.0
        myUtterance.preUtteranceDelay = 0.0
        myUtterance.rate = 0.2
        myUtterance.pitchMultiplier = 0.5 + 1.5 * Float(drand48())
        myUtterance.voice = AVSpeechSynthesisVoice(language: "en-US")
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
    
    func displayUserInput(input: String){
        display_.text = display_.text + "\n\n" + input
    }
    
    func displayLyrics(input: String){
        display_.text = display_.text + "\n\n" + input
    }
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
//        let translation = recognizer.translationInView(self.view)
//        displayLyrics(String(nextPitch))
//        nextRate = min(AVSpeechUtteranceMaximumSpeechRate, max(AVSpeechUtteranceMinimumSpeechRate, nextRate + Float(translation.x) / 100.0))
//        nextPitch = min(2, max(0.5, nextPitch + Float(translation.y) / 100.0))
//        recognizer.setTranslation(CGPointZero, inView: self.view)
    }
}


