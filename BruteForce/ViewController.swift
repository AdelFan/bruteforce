//
//  ViewController.swift
//  BruteForce
//
//  Created by Адель Ахметшин on 24.12.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var bruteButton: UIButton!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func generateClick(_ sender: Any) {
    }
    @IBAction func bruteClick(_ sender: Any) {
    }
    
}
func generatePassword() -> String {
    let numbers = 4
    let charPassword = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890!@#$%^&*()_+"
    let donePsw = String((0..<numbers).compactMap{ _ in charPassword.randomElement() })
    return donePsw
}

func bruteForce(passwordToUnlock: String) {
    let ALLOWED_CHARACTERS: [String] = String().printable.map { String($0) }
    var password: String = ""
    while password != passwordToUnlock {
        password = generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
        print(password)
    }
    print(password)
}

func indexOf(character: Character, _ array: [String]) -> Int {
return array.firstIndex(of: String(character))!
}

func characterAt(index: Int, _ array: [String]) -> Character {
return index < array.count ? Character(array[index])
: Character("")
}

func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
var str: String = string
if str.count <= 0 {
    str.append(characterAt(index: 0, array))
}
else {
    str.replace(at: str.count - 1,
                with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))
    if indexOf(character: str.last!, array) == 0 {
        str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
    }
}
return str
}


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
}
