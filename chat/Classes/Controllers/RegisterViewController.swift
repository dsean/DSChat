//
///  chat
//
//  Created by 楊德忻 on 2018/1/26.
//  Copyright © 2018年 sean. All rights reserved.
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
    
    // UILabel Pre-linked IBOutlets
    @IBOutlet weak var messageLabel: UILabel!
    
    var errorMessage:String! = ""
    
    // MARK: lifCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        messageLabel.text = ""
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Action
    
    // Dissmiss keyboad on touch began.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dissmissKeyboad()
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
        self.messageLabel.text = ""
        dissmissKeyboad()
        register(email: emailTextfield.text!, password: passwordTextfield.text!, username: nameTextfield.text!)
    }
    
    // MARK: function
    
    func dissmissKeyboad() {
        self.emailTextfield.resignFirstResponder()
        self.passwordTextfield.resignFirstResponder()
        self.nameTextfield.resignFirstResponder()
    }
    
    func register(email: String, password: String, username: String) {
        onRegister(email: email, password: password, username: username, callback:{(success) in
            if success {
                // Register success.
                print("Registration successful!")
                self.errorMessage = ""
                if let user = Auth.auth().currentUser {
                    // Save Register id and username
                    Database.database().reference(withPath: "ID/\(user.uid)/Profile/Name").setValue(self.nameTextfield.text!)
                    
                    // Login and go to chat View.
                    Utilities.goToChatView(controller:self)
                }
            }
            else {
                self.errorMessage = "Invalid email , password or username"
            }
            self.messageLabel.text = self.errorMessage
            SVProgressHUD.dismiss()
        })
    }
    
    func onRegister(email: String, password: String, username: String, callback: @escaping (_ success: Bool) -> Void) {
        // Check email password and username.
        
        if Utilities.checkEmail(email: email) && Utilities.checkPassword(password: password) && Utilities.checkUsername(username: username) {
            
            // Register with email and password.
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                callback(error == nil)
            }
        }
        else {
            callback(false)
        }
    }
}
