//
//  StringExtension.swift
//  BruteForce
//
//  Created by Адель Ахметшин on 20.01.2022.
//

import Foundation

extension String {
    var digits: String { return "0123456789" }
    var lowercase: String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase: String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters: String { return lowercase + uppercase }
    var printable: String { return digits + letters + punctuation }
    
    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
    
    func generatePassword(value: Int) -> String {
        let charPassword = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()_+"
        let correctPassword = String((0..<value).compactMap{ _ in charPassword.randomElement() })
        return correctPassword
    }
    
    func split(amountChar: Int) -> [String] {
        var currentIndex = 0
        var array = [String]()
        let length = self.count
        while currentIndex < length {
            let startIndex = index(self.startIndex, offsetBy: currentIndex)
            let endIndex = index(startIndex, offsetBy: amountChar, limitedBy: self.endIndex) ?? self.endIndex
            let substr = String( self[startIndex..<endIndex] )
            array.append(substr)
            currentIndex += amountChar
        }
        return array
    }
}
