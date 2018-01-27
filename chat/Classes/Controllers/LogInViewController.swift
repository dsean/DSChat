//
//  LogInViewController.swift
//  Flash Chat
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
        login()
    }
    
    // MARK: function
    
    func dissmissKeyboad() {
        self.emailTextfield.resignFirstResponder()
        self.passwordTextfield.resignFirstResponder()
    }
    
    func login() {
        SVProgressHUD.show()
        self.messageLabel.text = ""
        dissmissKeyboad()
        if Utilities.checkEmail(email: emailTextfield.text!) && Utilities.checkPassword(password: passwordTextfield.text!) {
            
            // Login with email and password.
            Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!, completion: { (user, error) in
                if error != nil {
                    
                    // Login fail.
                    print(error!)
                    
                    self.messageLabel.text = "Invalid email or password"
                }
                else {
                    
                    // Login success.
                    print("Login successful")
                    
                    // Login and go to chat View.
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
