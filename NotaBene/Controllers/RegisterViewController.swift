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
    
    @IBAction func signUp(_ sender: Any) {
        guard let email = emailText.text, !email.isEmpty else { print("Email is Empty"); return}
        guard let password = passwordText.text, !password.isEmpty else { print("Password is Empty"); return}
        
        let ref  = Database.database().reference().root
        
        if email != "" && password != "" {
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
