//
//  chat
//
//  Created by 楊德忻 on 2018/1/26.
//  Copyright © 2018年 sean. All rights reserved.
//
//  This is the view controller where users login


import UIKit
import Firebase
import SVProgressHUD

protocol LogInViewControllerDelegate {
    func onLogin(isSuccess:Bool)
}

class LogInViewController: UIViewController, LogInViewControllerDelegate {

    var delegate:LogInViewControllerDelegate?
    
    //Textfields pre-linked with IBOutlets
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    //UILabel pre-linked with IBOutlets
    @IBOutlet weak var messageLabel: UILabel!
    
    var errorMessage:String! = ""
    
    // MARK: lifCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: Action
    
    // Dissmiss keyboad on touch began.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.emailTextfield.resignFirstResponder()
        self.passwordTextfield.resignFirstResponder()
    }
    
    // Focus on password on touch return button.
    @IBAction func emailDidEndOnExit(_ sender: UITextField) {
        self.passwordTextfield.becomeFirstResponder()
    }
    
    // Dissmiss keyboad on touch finish button.
    @IBAction func passwordDidEndOnExit(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func onTouchLoginButton(_ sender: AnyObject) {
        SVProgressHUD.show()
        self.messageLabel.text = ""
        dissmissKeyboad()
        login(email: emailTextfield.text!, password: passwordTextfield.text!)
    }
    
    // MARK: function
    
    func dissmissKeyboad() {
        self.emailTextfield.resignFirstResponder()
        self.passwordTextfield.resignFirstResponder()
    }
    
    func login(email:String, password:String) {
        
        if Utilities.checkEmail(email: email) && Utilities.checkPassword(password: password) {
            
            // Login with email and password.
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error != nil {
    
                    // Login fail.
                    print(error!)
                    self.errorMessage = "Invalid email or password"
                    self.delegate?.onLogin(isSuccess: false)
                }
                else {
                    
                    // Login success.
                    print("Login successful")
                    self.errorMessage = ""
                    self.delegate?.onLogin(isSuccess: true)
                }
            })
        }
        else {
            self.errorMessage = "Invalid email or password"
            self.delegate?.onLogin(isSuccess: false)
        }
    }
    
    func onLogin(isSuccess:Bool) {
        DispatchQueue.main.async {
            if isSuccess {
                
                // Login and go to chat View.
                Utilities.goToChatView(controller:self)
            }
            self.messageLabel.text = self.errorMessage
            SVProgressHUD.dismiss()
        }
    }
}  
