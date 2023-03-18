//
//  ViewController.swift
//  Quizzler-iOS13
//
//  Created by Angela Yu on 12/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var timer = Timer()
    var quizBrain = QuizBrain()
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var firstChoiceButton: UIButton!
    @IBOutlet weak var secondChoiceButton: UIButton!
    @IBOutlet weak var thirdChoiceButton: UIButton!
    @IBOutlet weak var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstChoiceButton.layer.cornerRadius = 20
        secondChoiceButton.layer.cornerRadius = 20
        thirdChoiceButton.layer.cornerRadius = 20
        
        updateUI()
        
    }
    
    @IBAction func answerButtonPressed(_ sender: UIButton) {
        
        let userAnswer = sender.currentTitle!
        let userGotItRight = quizBrain.checkAnswer(userAnswer)
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut)
        {
            if userGotItRight {
                sender.backgroundColor = UIColor.green
            }
            else
            {
                sender.backgroundColor = UIColor.red
                // Needs fixing
//                if self.firstChoiceButton.currentTitle == self.quizBrain.getCorrectAnswer()
//                {
//                    self.firstChoiceButton.backgroundColor = UIColor.green
//                }
//                else if self.secondChoiceButton.currentTitle == self.quizBrain.getCorrectAnswer()
//                {
//                    self.firstChoiceButton.backgroundColor = UIColor.green
//                }
//                else if self.thirdChoiceButton.currentTitle == self.quizBrain.getCorrectAnswer()
//                {
//                    self.firstChoiceButton.backgroundColor = UIColor.green
//                }
            }
            
        }
        
        quizBrain.nextQuestion()
        
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(updateUI), userInfo: nil, repeats: false)
        
    }
    
    @objc func updateUI() {
        questionLabel.text = quizBrain.getQuestionText()
        let answerChoices = quizBrain.getAnswerChoices()
        
        firstChoiceButton.setTitle(answerChoices[0], for: .normal)
        secondChoiceButton.setTitle(answerChoices[1], for: .normal)
        thirdChoiceButton.setTitle(answerChoices[2], for: .normal)
        
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseInOut)
        {
            self.progressBar.setProgress(self.quizBrain.getProgress(), animated: true)
        }
        
        scoreLabel.text = "Score: \(quizBrain.score)"
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut)
        {
            self.firstChoiceButton.backgroundColor = UIColor.clear
            self.secondChoiceButton.backgroundColor = UIColor.clear
            self.thirdChoiceButton.backgroundColor = UIColor.clear
        }
        
        timer.invalidate()
    }
    
}

