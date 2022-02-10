//
//  BruteOperation.swift
//  BruteForce
//
//  Created by Адель Ахметшин on 22.01.2022.
//

import Foundation

class BruteOperation: Operation {
    var password: String
    
    init(password: String) {
        self.password = password
    }
    
    override func main() {
        bruteForce(passwordToUnlock: password)
    }
    
    /// Метод, который возвращает подобранный пароль
    /// - Parameter passwordToUnlock: String
    func bruteForce(passwordToUnlock: String) {
        let allowedCharacters: [String] = String().printable.map { String($0) }
        var password = ""
        while password != passwordToUnlock {
            password = generateBruteForce(password, fromArray: allowedCharacters)
            print(password)
        }
        print(password)
    }
    
    /// Метод, который возвращает первый элемент массива
    func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }
    
    /// Метод, который возвращает символ
    func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index])
        : Character("")
    }
    
    /// Метод, который начинает подбор пароля
    func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var string: String = string
        if string.count <= 0 {
            string.append(characterAt(index: 0, array))
        }
        else {
            string.replace(at: string.count - 1,
                        with: characterAt(index: (indexOf(character: string.last ?? " ", array) + 1) % array.count, array))
            if indexOf(character: string.last ?? " ", array) == 0 {
                string = String(generateBruteForce(String(string.dropLast()), fromArray: array)) + String(string.last ?? " ")
            }
        }
        return string
    }
}

