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
    // Pre-linked IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var nameTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
               /* self.performSegue(withIdentifier: "goToChat", sender: self)*/
            }
            SVProgressHUD.dismiss()
        })
    }
}
