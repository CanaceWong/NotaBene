//
//  ViewController.swift
//  NotaBene
//
//  Created by Olivia Beresford on 05/12/2017.
//  Copyright © 2017 NotaBeneTeam. All rights reserved.
//

import UIKit
import FirebaseAuth

class ViewController: UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var myLabel: UILabel!
    
    @IBAction func action(_ sender: UIButton) {
        if emailText.text != "" && passwordText.text != "" {
            if segmentControl.selectedSegmentIndex == 0 //login user
            {
                Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!, completion:{(user, error) in
                    if user != nil {
                        // sign in successful
                        self.performSegue(withIdentifier: "logged", sender: self)
                    } else {
                        if let myError = error?.localizedDescription{
                            print(myError)
                        } else {
                            print("ERROR")
                        }
                    }
                })
            }
            else //signup user
            {
                Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!, completion: { (user, error) in
                    if user != nil {
                        // sign up successful
                       self.performSegue(withIdentifier: "logged", sender: self)
                    } else {
                        if let myError = error?.localizedDescription{
                            print(myError)
                        } else {
                            print("ERROR")
                        }
                    }
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


