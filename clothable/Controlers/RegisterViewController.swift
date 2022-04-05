//
//  SecondViewController.swift
//  clothable
//
//  Created by Nikola Jeremic on 16.3.22..
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var myButtonRegister: UIButton!
    
    override func viewDidLoad() {
        myButtonRegister.layer.cornerRadius = 15
        myButtonRegister.layer.masksToBounds = true
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                        //navigate to the finalclothableview
                    self.performSegue(withIdentifier: "RegisterToLogin", sender: self)
                    
                }
            }
        }
    }
}
//MARK: - LoginEmail/PassTxtFieldDelegate2

extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    
    }
