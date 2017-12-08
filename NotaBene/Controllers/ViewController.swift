//
//  ViewController.swift
//  NotaBene
//
//  Created by Olivia Beresford on 05/12/2017.
//  Copyright © 2017 NotaBeneTeam. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    
//
//
//    @IBAction func signUpButton(_ sender: Any) {
//        guard let email = emailText.text, !email.isEmpty else { print("Email is Empty"); return}
//        guard let password = passwordText.text, !password.isEmpty else { print("Password is Empty"); return}
//
//        let ref  = Database.database().reference().root
//
//        if email != "" && password != "" {
//            Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
//                if error == nil {
//                    ref.child("users").child((user?.uid)!).setValue(email)
//                } else {
//                    if error != nil {
//                        print(error!)
//                    }
//                }
//            })
//        }
//    }
    
    @IBAction func logInButton(_ sender: Any) {
        guard let email = emailText.text, let password = passwordText.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if user != nil {
                self.performSegue(withIdentifier: "logged", sender: self)
            } else {
            if let error = error {
                print(error.localizedDescription)
            } else if Auth.auth().currentUser != nil{
                
                }
            }
        }
    }
    
//    @IBAction func action(_ sender: UIButton) {
//        if emailText.text != "" && passwordText.text != "" {
//            if segmentControl.selectedSegmentIndex == 0 //login user
//            {
//                Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!, completion:{(user, error) in
//                    if user != nil {
//                        // sign in successful
//                        self.performSegue(withIdentifier: "logged", sender: self)
//                    } else {
//                        if let myError = error?.localizedDescription{
//                            print(myError)
//                        } else {
//                            print("ERROR")
//                        }
//                    }
//                })
//            }
//            else //signup user
//            {
//                Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!, completion: { (user, error) in
//                    if user != nil {
//                        // sign up successful
//                       self.performSegue(withIdentifier: "logged", sender: self)
//                    } else {
//                        if let myError = error?.localizedDescription{
//                            print(myError)
//                        } else {
//                            print("ERROR")
//                        }
//                    }
//                })
//            }
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

