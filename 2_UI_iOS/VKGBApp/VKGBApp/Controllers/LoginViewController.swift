//
//  ViewController.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 12.08.2021.
//

import UIKit

let globalLogin = "root"
let globalPassword = "qwerty"

class LoginViewController: UIViewController {
    @IBOutlet var loginLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var loginField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        let result = checkLoginPassword(login: loginField.text!, password: passwordField.text!)
        print(result.0)
    }
    
    func checkLoginPassword(login: String, password: String) -> (String, Bool) {
        if login == globalLogin && password == globalPassword {
            return("Добро пожаловать", true)
        } else {
            return("Пара логин/пароль не корректны", false)
        }
    }
}

