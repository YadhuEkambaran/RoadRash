//
//  Util.swift
//  RoadRash
//
//  Created by yadhukrishnan E on 22/10/19.
//  Copyright © 2019 AYA. All rights reserved.
//

import Cocoa

class Util {

    static func showAlert(message: String) {
        let alert = NSAlert.init()
        alert.messageText = Constants.GAME_NAME
        alert.informativeText = message
        alert.addButton(withTitle: "OK")
        alert.runModal()
    }
    
    static func isEmpty(text: String) -> Bool {
        return text.isEmpty
    }
    
    static func isNumber(text: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let enteredCharacterSets = CharacterSet(charactersIn: text)
        return allowedCharacters.isSuperset(of: enteredCharacterSets)
    }
}
