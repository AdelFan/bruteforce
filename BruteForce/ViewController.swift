//
//  ViewController.swift
//  BruteForce
//
//  Created by Адель Ахметшин on 24.12.2021
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var bruteButton: UIButton!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var changeBackground: UIButton!
    
    private var isBlack = false {
        didSet {
            if isBlack {
                activityIndicator.alpha = numberValues.IndicatorTrue.rawValue
                activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.alpha = numberValues.IndicatorFalse.rawValue
            }
        }
    }
    
    private var backgroundColor = false {
        didSet {
            if backgroundColor {
                view.backgroundColor = .purple
            } else {
                view.backgroundColor = .white
            }
        }
    }
    
    /// Метод генерации пароля
    /// - Parameter sender: Any
    @IBAction func generateClick(_ sender: Any) {
        if isBlack {
            generateButton.alpha = numberValues.IndicatorFalse.rawValue
        } else if isBlack == false {
            label.text = "Password"
            textField.isSecureTextEntry = true
            textField.text = String().generatePassword(value: numberCharacters.characters.rawValue)
        }
    }
    
    /// Обработка нажатия на кнопку Brute
    /// - Parameter sender: Any
    @IBAction func bruteClick(_ sender: Any) {
        let queue = OperationQueue()
        isBlack.toggle()
        queue.addOperation { [weak self] in
            self?.bruteForce(passwordToUnlock: self?.textField.text ?? "")
            self?.isBlack = false
            self?.textField.isSecureTextEntry = false
            self?.label.text = self?.textField.text
        }
    }
    
    /// Метод изменения цвета фона
    /// - Parameter sender: Any
    @IBAction func changeBackground(_ sender: Any) {
        backgroundColor.toggle()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.isSecureTextEntry = true
        label.text = "Password"
        activityIndicator.alpha = numberValues.IndicatorFalse.rawValue
    }
    
    /// Метод подбора пароля
    /// - Parameter passwordToUnlock: String
    func bruteForce(passwordToUnlock: String) {
        let ALLOWED_CHARACTERS: [String] = String().printable.map { String($0) }
        var password = ""
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
}

enum numberValues: Double {
    case IndicatorTrue = 1.0
    case IndicatorFalse = 0.0
}

enum numberCharacters: Int {
    case characters = 4
}
