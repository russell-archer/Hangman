//
//  Game.swift
//  Hangman
//
//  Created by Russell Archer on 26/05/2019.
//  Copyright © 2019 Russell Archer. All rights reserved.
//

import UIKit

protocol GameProtocol {
    func secretWord(template: String)
    func guess(correct: Bool)
    func guessedBefore(letter: String)
    func guessesRemaining(n: Int)
    func gameOver(youWin: Bool)
}

class Game {
    fileprivate var nGuessesRemaining = 0

    let secretWord = SecretWord()
    var delegate: GameProtocol?
    enum difficultyLevel: Int { case Easy = 12, Medium = 10, Hard = 8}
    
    func play(difficulty: difficultyLevel) {
        nGuessesRemaining = difficulty.rawValue
        secretWord.generateNewSecretWord()
        delegate?.secretWord(template: secretWord.template)
    }
    
    func guess(letter: String) {
        guard nGuessesRemaining > 0 else { return }
        
        if secretWord.hasGuessBeenTriedBefore(guess: letter) {
            delegate?.guessedBefore(letter: letter)
            return
        }
        
        nGuessesRemaining -= 1
        
        delegate?.guess(correct: secretWord.guessLetter(guess: letter))
        delegate?.secretWord(template: secretWord.template)
        delegate?.guessesRemaining(n: nGuessesRemaining)
        
        if secretWord.complete || nGuessesRemaining == 0 {
            delegate?.gameOver(youWin: secretWord.complete)
        }
    }
}
