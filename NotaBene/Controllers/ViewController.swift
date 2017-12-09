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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

