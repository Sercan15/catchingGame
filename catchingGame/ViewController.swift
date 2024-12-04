//
//  ViewController.swift
//  catchingGame
//
//  Created by Sercan Yeşilyurt on 4.12.2024.
//

import UIKit

class ViewController: UIViewController {
    
    var score = 0
    var timer = Timer()
    var counter = 0
    var imageArray = [UIImageView]()
    var hideTimer = Timer()
    var highscore = 0

    @IBOutlet weak var highScoreLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image1: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storedHighScore = UserDefaults.standard.integer(forKey: "highscore")
        
        scoreLabel.text = "Score : \(score)"
        
        image1.isUserInteractionEnabled = true
        image2.isUserInteractionEnabled = true
        image3.isUserInteractionEnabled = true
        image4.isUserInteractionEnabled = true
        image5.isUserInteractionEnabled = true
        image6.isUserInteractionEnabled = true
        
        let recognizer1 =   UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer2 =   UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer3 =   UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer4 =   UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer5 =   UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        let recognizer6 =   UITapGestureRecognizer(target: self, action: #selector(increaseScore))
        
        image1.addGestureRecognizer(recognizer1)
        image2.addGestureRecognizer(recognizer2)
        image3.addGestureRecognizer(recognizer3)
        image4.addGestureRecognizer(recognizer4)
        image5.addGestureRecognizer(recognizer5)
        image6.addGestureRecognizer(recognizer6)
        
        imageArray = [image1,image2,image3,image4,image5,image6]
        
        // Timers
        
        counter = 10
        timeLabel.text = "Time : \(counter)"
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(decrease), userInfo: nil, repeats: true)
        hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(hideImage), userInfo: nil, repeats: true)
        hideImage()
    }
    
    @objc func hideImage(){
        for image in imageArray{
            image.isHidden = true
        }
        let random = arc4random_uniform(UInt32(imageArray.count-1))
        imageArray[Int(random)].isHidden = false
    }
    
    @objc func increaseScore(){
        score += 1
        scoreLabel.text = "Score : \(score)"
    }
    
    @objc func decrease(){
    counter -= 1
    timeLabel.text = "Time : \(counter)"
    if counter == 0{
        timer.invalidate()
        hideTimer.invalidate()
        for image in imageArray{
            image.isHidden = true
        }
        
        // Highscore
        
        if self.score > self.highscore{
            self.highscore = self.score
            highScoreLabel.text = "Highscore : \(self.highscore)"
            UserDefaults.standard.set(self.highscore, forKey: "highscore")
        }
        
        // Alert codes
        
        let alert = UIAlertController(title: "Time's Up", message: "Your score is \(score) , Do you want to play again", preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.cancel, handler: nil)
        let rePlay = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { UIAlertAction in
            
            self.score = 0
            self.scoreLabel.text = "Score : \(self.score)"
            self.counter = 10
            self.timeLabel.text = "Time : \(self.counter)"
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.decrease), userInfo: nil, repeats: true)
            self.hideTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.hideImage), userInfo: nil, repeats: true)
            
        }
        alert.addAction(okButton)
        alert.addAction(rePlay)
        present(alert, animated: true, completion: nil)
    }
    
        
    }
}



