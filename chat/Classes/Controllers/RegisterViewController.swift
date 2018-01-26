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
    //Pre-linked IBOutlets
    @IBOutlet var emailTextfield: UITextField!
    @IBOutlet var passwordTextfield: UITextField!
    @IBOutlet var nameTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func registerPressed(_ sender: AnyObject) {
        SVProgressHUD.show()
        Auth.auth().createUser(withEmail: emailTextfield.text!, password: passwordTextfield.text!, completion: { (user, error) in
            if error != nil {
                SVProgressHUD.dismiss()
                print(error!)
            } else {
                //success
                print("Registration successful!")
                if let user = Auth.auth().currentUser{
                    Database.database().reference(withPath: "ID/\(user.uid)/Profile/Name").setValue(self.nameTextfield.text!)
                }
                SVProgressHUD.dismiss()
                
               /* self.performSegue(withIdentifier: "goToChat", sender: self)*/
            }
        })
    }
}
