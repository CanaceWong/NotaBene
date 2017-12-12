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

        if self.emailText.text == "" || self.passwordText.text == "" {
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signInAndRetrieveData(withEmail: self.emailText.text!, password: self.passwordText.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    //Go to the HomeViewController if the login is sucessful
                     self.performSegue(withIdentifier: "logged", sender: self)
                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        // Add relevant code here
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

