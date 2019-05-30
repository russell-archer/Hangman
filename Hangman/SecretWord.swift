//
//  SecretWord.swift
//  Hangman
//
//  Created by Russell Archer on 25/05/2019.
//  Copyright © 2019 Russell Archer. All rights reserved.
//

import UIKit

class SecretWord {
    fileprivate let words = ["Sausage", "Kettle", "Astronomer", "Policeman", "Pizza", "Train","Cat", "Snake", "Flower", "Eagle", "Skateboard", "Plane", "Horse", "Tree", "Coffee", "Guitar", "Computer", "Sea", "Watch", "Book", "Pen", "Ice", "iPhone", "Rocket"]
    fileprivate var previousSecretWords = Array<String>()  // List of previously used secret words
    fileprivate var correctGuesses = Array<String>()  // Correct guesses in the current game
    fileprivate var incorrectGuesses = Array<String>()  // Incorrect guesses in the current game

    var template = ""  // The "--e--e--k" type template for the secret word displayed to the user
    var word = ""  // The secret word
    var complete = false
    
    func generateNewSecretWord() {
        var tmpWord = ""
        
        // Have we used up all the potential secret words?
        if previousSecretWords.count == words.count {
            previousSecretWords.removeAll()  // Start again
        }
        
        while tmpWord.count == 0 {
            let n = Int.random(in: 0..<words.count)
            tmpWord = words[n]
            
            if !previousSecretWords.contains(tmpWord) {
                word = tmpWord
                template = String(repeating: "-", count: word.count)
                correctGuesses.removeAll()
                incorrectGuesses.removeAll()
                complete = false
                previousSecretWords.append(tmpWord)
            }
        }
    }
    
    func hasGuessBeenTriedBefore(guess: String) -> Bool {
        if correctGuesses.contains(String(guess).lowercased()) || incorrectGuesses.contains(String(guess).lowercased()) {
            return true
        }
        
        return false
    }
    
    func guessLetter(guess: String) -> Bool {
        var match = false
        
        // Build a new template each time the player makes a guess
        template = ""
        word.forEach { letter in
            if correctGuesses.contains(String(letter).lowercased()) {
                template += String(letter).lowercased()
            } else if String(letter).lowercased() == guess.lowercased() {
                match = true
                correctGuesses.append(guess.lowercased())
                template += guess.lowercased()
            } else {
                incorrectGuesses.append(guess.lowercased())
                template += "-"
            }
        }
        
        if !template.contains("-") {
            complete = true
        }
        
        return match
    }
}
