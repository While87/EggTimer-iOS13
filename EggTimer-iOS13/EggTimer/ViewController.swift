//
//  ViewController.swift
//  EggTimer
//
//  Created by while on 08/07/2019.
//  Copyright © 2019 while. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressRemaining: UIProgressView!
    
    
    let eggTimes = ["Soft": 300, "Medium": 480, "Hard": 720]
    var countTime = 0
    var timer = Timer()
    var totalTime = 0
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        titleLabel.text = sender.currentTitle
        progressRemaining.alpha = 1
        progressRemaining.progress = 0
        timer.invalidate()
        countTime = eggTimes[sender.currentTitle!]!
        totalTime = eggTimes[sender.currentTitle!]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if (countTime > 0) {
            titleLabel.text = ("Please, wait \(countTime) seconds.")
            progressRemaining.progress = Float(totalTime - countTime)/Float(totalTime)
            countTime -= 1
        }   else if countTime == 0 {
            timer.invalidate()
            titleLabel.text = "Done!"
            progressRemaining.alpha = 0
            playAlarm()
        }
    }
    
    func playAlarm()
    {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
