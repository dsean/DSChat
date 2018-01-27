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

class LogInViewController: UIViewController {

    //Textfields pre-linked with IBOutlets
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    //UILabel pre-linked with IBOutlets
    @IBOutlet weak var messageLabel: UILabel!
    
    // MARK: lifCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        login(email: emailTextfield.text!, password: passwordTextfield.text!)
    }
    
    // MARK: function
    
    func dissmissKeyboad() {
        self.emailTextfield.resignFirstResponder()
        self.passwordTextfield.resignFirstResponder()
    }
    
    func login(email:String, password:String) {
        SVProgressHUD.show()
        self.messageLabel.text = ""
        dissmissKeyboad()
        if Utilities.checkEmail(email: email) && Utilities.checkPassword(password: password) {
            
            // Login with email and password.
            Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                if error != nil {
                    
                    // Login fail.
                    print(error!)
                    
                    self.messageLabel.text = "Invalid email or password"
                }
                else {
                    
                    // Login success.
                    print("Login successful")
                    
                    // Login and go to chat View.
                    Utilities.goToChatView(controller:self)
                }
                SVProgressHUD.dismiss()
            })
        }
        else {
            print("Invalid email or password")
            messageLabel.text = "Invalid email or password"
            SVProgressHUD.dismiss()
        }
    }
}  
