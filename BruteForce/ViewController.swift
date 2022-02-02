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
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var changeBackground: UIButton!
    private var arrayPass: [String] = []
    
    
    /// Изменение свойства ActivityIndicator
    private var isActivityIndicator = false {
        didSet {
            if isActivityIndicator {
                activityIndicator.alpha = numberValues.IndicatorTrue
                generateButton.alpha = numberValues.IndicatorFalse
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
                activityIndicator.alpha = numberValues.IndicatorFalse
                generateButton.alpha = numberValues.IndicatorTrue
            }
        }
    }
    
    /// Метод изменения UI после завершения подбора пароля
    private func doneBrute() {
        DispatchQueue.main.async {
            self.label.text = self.textField.text
            self.textField.isSecureTextEntry = false
            self.isActivityIndicator = false
        }
    }
    
    /// Изменение заднего фона
    private var backgroundColor = false {
        didSet {
            if backgroundColor {
                view.backgroundColor = .purple
            } else {
                view.backgroundColor = .white
            }
        }
    }
    
    /// Обработка нажатия на кнопку Generate
    /// - Parameter sender: Any
    @IBAction func generateClick(_ sender: Any) {
        let queue = OperationQueue()
        textField.isSecureTextEntry = true
        textField.text = String().generatePassword(value: numberValues.characters)
        isActivityIndicator.toggle()
        arrayPass = textField.text?.split(amountChar: numberValues.amountChar) ?? [" "]
        for char in arrayPass {
            let operationA = BruteOperation(password: char)
            queue.addOperation(operationA)
        }
        queue.addBarrierBlock {
            self.doneBrute()
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
        activityIndicator.alpha = numberValues.IndicatorFalse
    }
}

class numberValues {
    static let IndicatorTrue = 1.0
    static let IndicatorFalse = 0.0
    static let characters = 12
    static let count = 0
    static let amountChar = 3
}
