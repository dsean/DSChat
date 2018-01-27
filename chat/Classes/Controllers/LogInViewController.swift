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
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: emailTextfield.text!, password: passwordTextfield.text!, completion: { (user, error) in
            if error != nil {
                print(error!)
                
                
            }
            else {
                print("Login successful")
                
                // Login and go to chat View.
            }
            
            SVProgressHUD.dismiss()
        })
    }
}  
