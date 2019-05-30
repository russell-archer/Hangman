#  Hangman Game

Simple, non-graphical Hangman game.

## Game Rules

* The app picks a secret “random” word from a list (we keep a record of what words have been used so a word never repeats)

* A series of underscore characters are displayed, one for each letter in the secret word

* The player then makes a guess at a character which may be part of the secret word:
    * If they guess correctly, the app fills puts the character(s) in the relevant position(s) in the series of underscores
    * If they guess incorrectly, the user’s count of remaining guesses is decremented
    
* There are three levels: easy, medium and hard.  For the easy level the player starts with 12 guesses, medium = 10, hard = 8

* The player wins if all the missing characters are correctly guessed before the available guesses reaches zero

* The player loses if their available guesses reaches zero and underscores remain unfilled

