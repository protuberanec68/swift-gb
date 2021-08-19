//
//  ViewController.swift
//  VKGBApp
//
//  Created by Игорь Андрианов on 12.08.2021.
//

import UIKit

let globalLogin = "123"
let globalPassword = "123"

class LoginViewController: UIViewController {
    @IBOutlet var loginLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var loginField: UITextField!
    @IBOutlet var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func toLoginScreen(unwindSegue: UIStoryboardSegue) { }
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        if checkLoginPassword(
            login: loginField.text!,
            password: passwordField.text!) {
            loginField.text = ""
            passwordField.text = ""
            performSegue(withIdentifier: "loginSegue", sender: nil)
        } else {
            alertWrongLogin()
            passwordField.text = ""
        }
    }
    
    func checkLoginPassword(login: String, password: String) -> Bool {
        return login == globalLogin && password == globalPassword
    }
    
    func alertWrongLogin() {
        let alertController = UIAlertController(
            title: "Ошибка",
            message: "Пара логин/пароль неверна",
            preferredStyle: .alert)
        let alertAction = UIAlertAction(
            title: "Ясно",
            style: .cancel,
            handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true)
    }
}

