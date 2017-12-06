//
//  ViewControllerSave.swift
//  NotaBene
//
//  Created by Olivia Beresford on 06/12/2017.
//  Copyright © 2017 NotaBeneTeam. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewControllerSave: UIViewController {

    @IBOutlet weak var entryText: UITextField!
    
    var ref:DatabaseReference?
    
    @IBAction func saveEntry(_ sender: Any) {
        ref = Database.database().reference()
        
        if entryText.text != "" {
            ref?.child("entries").childByAutoId().setValue(entryText.text)

        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
