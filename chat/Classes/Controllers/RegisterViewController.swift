//
//  RegisterViewController.swift
//  Flash Chat
//
//  This is the View Controller which registers new users with Firebase
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {
    // Textfields Pre-linked IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var nameTextfield: UITextField!
    
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
        self.nameTextfield.resignFirstResponder()
    }
    
    // Focus on password on touch return button.
    @IBAction func emailDidEndOnExit(_ sender: UITextField) {
        self.passwordTextfield.becomeFirstResponder()
    }
    
    // Focus on name on touch return button.
    @IBAction func passwordDidEndOnExit(_ sender: UITextField) {
        self.nameTextfield.becomeFirstResponder()
    }
    
    // Dissmiss keyboad on touch finish button.
    @IBAction func usernameDidEndOnExit(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    @IBAction func onTouchRegisterButton(_ sender: AnyObject) {
        SVProgressHUD.show()
        
        // Register with email and password.
        
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!, completion: { (user, error) in
            if error != nil {
                
                // Register fail.
                print(error!)
            }
            else {
                
                // Register success.
                print("Registration successful!")
                if let user = Auth.auth().currentUser {
                    // Save Register id and username
                    Database.database().reference(withPath: "ID/\(user.uid)/Profile/Name").setValue(self.nameTextfield.text!)
                }
                
                // Login and go to chat View.
            }
            SVProgressHUD.dismiss()
        })
    }
}
