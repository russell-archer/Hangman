//
//  ViewController+GameProtocol.swift
//  Hangman
//
//  Created by Russell Archer on 29/05/2019.
//  Copyright © 2019 Russell Archer. All rights reserved.
//

import UIKit

extension ViewController: GameProtocol {
    // MARK: GameProtocol implementation
    func secretWord(template: String) {
        secretWordDisplay.text = template
    }
    
    func guess(correct: Bool) {
        correctOrIncorrectGuessLabel.isHidden = false
        
        if correct {
            correctOrIncorrectGuessLabel.textColor = UIColor.green
            correctOrIncorrectGuessLabel.text = "Correct!"
        } else {
            correctOrIncorrectGuessLabel.textColor = UIColor.red
            correctOrIncorrectGuessLabel.text = "Wrong!"
        }
    }
    
    func guessedBefore(letter: String) {
        correctOrIncorrectGuessLabel.textColor = UIColor.orange
        correctOrIncorrectGuessLabel.text = "Already tried this!"
    }
    
    func guessesRemaining(n: Int) {
        remainingGuessesLabel.text = "You have \(String(n)) guesses remaining"
    }
    
    func gameOver(youWin: Bool) {
        view.resignFirstResponder()
        gameDifficultySegmentedControl.isUserInteractionEnabled = true
        playing = false
        winLoseLabel.isHidden = false
        correctOrIncorrectGuessLabel.isHidden = false
        playAgainButton.setTitle("Play Again!", for: .normal)
        
        if youWin {
            winLoseLabel.textColor = UIColor.green
            winLoseLabel.text = "You win!!"
        } else {
            winLoseLabel.textColor = UIColor.red
            winLoseLabel.text = "You lose!"
            correctOrIncorrectGuessLabel.textColor = UIColor.blue
            correctOrIncorrectGuessLabel.text = #"The word was "\#(game.secretWord.word)""#
            secretWordDisplay.text = game.secretWord.word
        }
    }
}
