//
//  ViewController.swift
//  Hangman
//
//  Created by Russell Archer on 22/05/2019.
//  Copyright © 2019 Russell Archer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var secretWordDisplay: UILabel!
    @IBOutlet weak var letterGuessLabel: UILabel!
    @IBOutlet weak var remainingGuessesLabel: UILabel!
    @IBOutlet weak var correctOrIncorrectGuessLabel: UILabel!
    @IBOutlet weak var winLoseLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var gameDifficultySegmentedControl: UISegmentedControl!
    
    var playing = true
    var gameDifficulty = Game.difficultyLevel.Easy {
        didSet {
            remainingGuessesLabel.text = "You have \(String(gameDifficulty.rawValue)) guesses remaining"
        }
    }

    let game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        game.delegate = self  // Set ourselves as a delegate of Game so we get feedback
        (view as! CustomView).delegate = self  // Set ourselves as a delegate of our custom view
        
        startNewGame()
    }
    
    func startNewGame() {
        view.becomeFirstResponder()  // Show the keyboard
        gameDifficultySegmentedControl.isUserInteractionEnabled = false
        playAgainButton.setTitle("I give up!!", for: .normal)
        playing = true
        remainingGuessesLabel.text = "You have \(String(gameDifficulty.rawValue)) guesses remaining"
        letterGuessLabel.text = "-"
        correctOrIncorrectGuessLabel.isHidden = true
        winLoseLabel.isHidden = true
        
        game.play(difficulty: gameDifficulty)
    }
    
    @IBAction func playAgainTapped(_ sender: Any) {
        if playing {
            view.resignFirstResponder()
            gameDifficultySegmentedControl.isUserInteractionEnabled = true
            playing = false
            winLoseLabel.isHidden = false
            correctOrIncorrectGuessLabel.textColor = UIColor.blue
            correctOrIncorrectGuessLabel.isHidden = false
            playAgainButton.setTitle("Play Again!", for: .normal)
            winLoseLabel.textColor = UIColor.red
            winLoseLabel.text = "You lose!"
            correctOrIncorrectGuessLabel.text = #"The word was "\#(game.secretWord.word)""#
            secretWordDisplay.text = game.secretWord.word
            
        } else {
            startNewGame()
        }
    }
    
    @IBAction func gameDifficultyChanged(_ sender: Any) {
        switch gameDifficultySegmentedControl.selectedSegmentIndex {
        case 0: gameDifficulty = Game.difficultyLevel.Easy
        case 1: gameDifficulty = Game.difficultyLevel.Medium
        case 2: gameDifficulty = Game.difficultyLevel.Hard
        default: gameDifficulty = Game.difficultyLevel.Easy
        }
    }
}

extension ViewController: CustomViewProtocol {
    // MARK: CustomViewProtocol implementation
    func textDidArrive(text: String) {
        letterGuessLabel.text = text
        game.guess(letter: text)
    }
}
