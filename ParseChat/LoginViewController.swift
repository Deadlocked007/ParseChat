//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Siraj Zaneer on 12/2/17.
//  Copyright © 2017 Siraj Zaneer. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let background = UIImage(named: "background")!
        self.navigationController!.navigationBar.setBackgroundImage(background, for: .default)
        
        containerView.layer.borderWidth = 0.5
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        
        emailField.becomeFirstResponder()
    }
    
    @IBAction func onOutsideTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func onSignIn(_ sender: Any) {
        guard let email = emailField.text, !email.isEmpty else {
            return
        }
        
        guard let password = passwordField.text, !password.isEmpty else {
            return
        }
        
        PFUser.logInWithUsername(inBackground: email, password: password) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if user != nil {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
}
