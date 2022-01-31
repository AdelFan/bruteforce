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
                activityIndicator.startAnimating()
            } else {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.alpha = numberValues.IndicatorFalse
            }
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
        if isActivityIndicator {
            generateButton.alpha = numberValues.IndicatorFalse
        } else if isActivityIndicator == false {
            textField.isSecureTextEntry = true
            textField.text = String().generatePassword(value: numberValues.characters)
            isActivityIndicator.toggle()
            arrayPass = textField.text?.split(len: [3, 3, 3, 3]) ?? [" "]
            for i in arrayPass {
                let operationA = BruteOperation(password: i)
                let queue = OperationQueue()
                queue.addOperation(operationA)
                queue.addBarrierBlock {
                    self.label.text = self.textField.text
                    self.textField.isSecureTextEntry = false
                    self.isActivityIndicator = false
                }
            }
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
        label.text = ""
        activityIndicator.alpha = numberValues.IndicatorFalse
    }
}

class numberValues {
    static let IndicatorTrue = 1.0
    static let IndicatorFalse = 0.0
    static let characters = 12
    static let count = 0
}
