//
//  CustomView.swift
//  Hangman
//
//  Created by Russell Archer on 24/05/2019.
//  Copyright © 2019 Russell Archer. All rights reserved.
//

import UIKit

protocol CustomViewProtocol {
    func textDidArrive(text: String)
}

class CustomView: UIView, UIKeyInput {
    var hasText = false
    var delegate: CustomViewProtocol?
    
    var keyboardType: UIKeyboardType {
        get { return .default }  // Use the default keyboard
        set {}
    }
    
    var autocorrectionType: UITextAutocorrectionType {
        get { return .no }  // Disable autocorrection
        set {}
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var canBecomeFirstResponder: Bool {
        return true  // Allows us to show the keyboard
    }
    
    func insertText(_ text: String) {
        // Text arrives one character at a time as the user taps on the keyboard
        delegate?.textDidArrive(text: text)
    }
    
    func deleteBackward() {}
}
