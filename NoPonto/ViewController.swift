//
//  ViewController.swift
//  NoPonto
//
//  Created by Thiago Valentim on 16/06/22.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    @IBOutlet weak var infoCountLabel: UILabel!
    @IBOutlet weak var softButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    @IBOutlet weak var barProgessView: UIProgressView!
    @IBOutlet weak var progressLabel: UILabel!
    
    
    let eggTimes = ["Mole": 3, "Médio": 8, "Duro": 10]
    var secondsRemaining = 60
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    var alert: AVAudioPlayer?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    @IBAction func tappedHardnessSelectedButton(_ sender: UIButton) {
        timer.invalidate()
        let hardness = sender.currentTitle
        totalTime = eggTimes[hardness ?? "nil"] ?? 0
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        barProgessView.progress = 0.0
        secondsPassed = 0
        infoCountLabel.text = hardness
    }
    
    @IBAction func tappedCleanButton(_ sender: UIButton) {
        barProgessView.progress = 0.0
        secondsPassed = 0
        infoCountLabel.text = "Escolha qual o ponto você quer do ovo."
        progressLabel.text = "Tempo de preparo."
        timer.invalidate()
        alert?.stop()
    }
    
    
    @objc func updateTimer(){
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressLabel.text = "Cozinhando..."
            barProgessView.progress = Float(secondsPassed)/Float(totalTime)
            
        }else {
            timer.invalidate()
            progressLabel.text = "Pronto!!!"
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            alert = try! AVAudioPlayer(contentsOf: url!)
            alert?.play()
        }
    }
    
    
}


