//
//  mainViewController.swift
//  Week4 Exercise2
//
//  Created by Hanna Chen on 1/30/17.
//  Copyright © 2017 Rethink Canada. All rights reserved.
//

import UIKit

class mainViewController: UIViewController {
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var responseLabel: UILabel!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var createAccountButton: UIButton!
    
    var server = Server()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        // Logged in
        if server.loginState {
            
            let logoutResult = server.logOut()
            
            if logoutResult.successful {
                
                self.createAccountButton.isHidden = false
                self.loginButton.setTitle("Login", for: UIControlState.normal)
                showMessage(successful: logoutResult.successful, message: logoutResult.message)
                
                resetFields()
            }
        } else {
            
            let loginResult = server.logIn(username: usernameTextField.text, password: passwordTextField.text)
            showMessage(successful: loginResult.successful, message: loginResult.message)
            
            if loginResult.successful {
                self.createAccountButton.isHidden = true
                self.loginButton.setTitle("Logout", for: UIControlState.normal)
            }
        }
    }
    
    @IBAction func createAccountButtonPressed(_ sender: UIButton) {
        let registerResult = server.createNewUser(username: usernameTextField.text, password: passwordTextField.text)
        showMessage(successful: registerResult.successful, message: registerResult.message)
        
        print(server.registeredUsers)
    }
    
    func showMessage(successful: Bool, message: String) {
        self.responseLabel.textColor = successful ? UIColor.success : UIColor.error
        self.responseLabel.text = message
    }
    
    func resetFields() {
        self.usernameTextField.text = nil
        self.passwordTextField.text = nil
    }
}

extension UIColor {
    static var error: UIColor  { get { return UIColor(red: 185/255, green: 0/255, blue: 5/255, alpha: 1) } }
    static var success: UIColor { get { return UIColor(red: 2/255, green: 122/255, blue: 0/255, alpha: 1) } }
}
