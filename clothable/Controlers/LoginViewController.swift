//
//  LoginViewController.swift
//  clothable
//
//  Created by Nikola Jeremic on 16.3.22..
//

import UIKit
import Firebase
import SwiftUI

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var paswsordTextfield: UITextField!
    @IBOutlet weak var myButton: UIButton!
    
    override func viewDidLoad() {
        myButton.layer.cornerRadius = 15
        myButton.layer.masksToBounds = true
        emailTextfield.delegate = self
        paswsordTextfield.delegate = self
        emailTextfield.layer.cornerRadius = 20
        paswsordTextfield.layer.cornerRadius = 20
    }
    @IBAction func loginPressed(_ sender: UIButton) {
        
        emailTextfield.endEditing(true)
        
        if let email = emailTextfield.text, let password = paswsordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                
                if let e = error {
                    print(e)
                    
                    print("Pogresna lozinka")
                } else {
                    self!.performSegue(withIdentifier: "LoginToFinal", sender: self)
                }
                
            }
            
        }
        
    }
    
    
    
}
//MARK: - LoginEmail/PassTxtFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextfield.endEditing(true)
        paswsordTextfield.endEditing(true)
        return true
    }
    
    }

