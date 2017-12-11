//
//  RegisterViewController.swift
//  NotaBene
//
//  Created by Olivia Beresford on 08/12/2017.
//  Copyright © 2017 NotaBeneTeam. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
//    @IBAction func signUp(_ sender: Any) {
//        guard let email = emailText.text, !email.isEmpty else { print("Email is Empty"); return}
//        guard let password = passwordText.text, !password.isEmpty else { print("Password is Empty"); return}
//
//        let ref  = Database.database().reference().root
//
//        if (self.emailText.text != nil) || self.passwordText.text == "" {
//            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
//
//            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
//            alertController.addAction(defaultAction)
//
//            self.present(alertController, animated: true, completion: nil)
//
//        } else if email != "" && password != "" {
//            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
//                if error == nil {
//                    ref.child("users").child((user?.uid)!).setValue(email)
//                    self.performSegue(withIdentifier: "registered", sender: self)
//                } else {
//                    if error != nil {
//                        print(error!)
//                    }
//                }
//            })
//        }
//    }
//
    @IBAction func signUp(_ sender: Any) {
        if emailText.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (user, error) in
                
                if error == nil {
                   
                    guard let email = self.emailText.text, !email.isEmpty else { print("Email is Empty"); return}
                    guard let password = self.passwordText.text, !password.isEmpty else { print("Password is Empty"); return}
                    let ref  = Database.database().reference().root

                    Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error == nil {
                            ref.child("users").child((user?.uid)!).setValue(email)
                            self.performSegue(withIdentifier: "registered", sender: self)
                        } else {
                            if error != nil {
                                print(error!)
                            }
                        }
                    })
                    let alertController = UIAlertController(title: "You have signed up successfully!", message: "Please go to Log in", preferredStyle: UIAlertControllerStyle.alert)
                    let ok = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: {(action) -> Void in
                        self.performSegue(withIdentifier: "VC2", sender: self)
                    })
                    
                    alertController.addAction(ok)
                    self.present(alertController, animated: true, completion: nil)
                 
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
