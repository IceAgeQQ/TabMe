//
//  ViewController.swift
//  Tap Me
//
//  Created by Chao Xu on 15/6/12.
//  Copyright (c) 2015年 Chao Xu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet var scoreLabel: UILabel!
    @IBOutlet var timerLabel: UILabel!
    var count = 0
    var seconds = 0
    var timer = NSTimer()
    
    //avfoundation
    var buttonBeep = AVAudioPlayer()
    var secondBeep = AVAudioPlayer()
    var backgroundMusic = AVAudioPlayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bg_tile.png")!)
        scoreLabel.backgroundColor = UIColor(patternImage: UIImage(named: "field_score.png")!)
        timerLabel.backgroundColor = UIColor(patternImage: UIImage(named: "field_time.png")!)
        
        buttonBeep = self.setupAudioPlayerWithFile("ButtonTap", type: "wav")
        secondBeep = self.setupAudioPlayerWithFile("SecondBeep", type: "wav")
        backgroundMusic = self.setupAudioPlayerWithFile("HallOfTheMountainKing", type: "mp3")
        
        setupGame()
        
    }
    
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer  {
    
        var path = NSBundle .mainBundle().pathForResource(file as String , ofType: type as String)
        var url = NSURL.fileURLWithPath(path!)
        
        var error: NSError?
        
        var audioPlayer:AVAudioPlayer?
        audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        
        return audioPlayer!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    @IBAction func buttonPressed() {
        count++
        scoreLabel.text = "Score \n\(count)"
        buttonBeep.play()
    }
    
    func setupGame() {
        seconds = 10
        count = 0
        timerLabel.text = "Time: \(seconds)"
        scoreLabel.text = "Score: \(count)"
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("subtractTime"), userInfo: nil, repeats: true)
        
        backgroundMusic.volume = 0.3
        backgroundMusic.play()
    }
    
    func subtractTime() {
        secondBeep.play()
        seconds--
        timerLabel.text = "Time: \(seconds)"
        
        if(seconds == 0){
            timer.invalidate()
            
            let alert = UIAlertController(title: "Time is up!", message: "You scored \(count) points", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.Default, handler: {
                action in self.setupGame()
                
            }))
            presentViewController(alert, animated: true, completion:nil)
        }
    }
    
    

}


































