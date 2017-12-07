//
//  EntryViewController.swift
//  NotaBene
//
//  Created by Olivia Beresford on 06/12/2017.
//  Copyright © 2017 NotaBeneTeam. All rights reserved.
//

import UIKit
import FirebaseDatabase

class Entry: UIViewController {
    
    @IBOutlet weak var entryTitle: UITextField!
    @IBOutlet weak var entryContent: UITextField!
    
    var ref:DatabaseReference?
    
    @IBAction func saveEntry(_ sender: Any) {
        ref = Database.database().reference()
        print("hello")
        if entryTitle.text != "" {
            let key = ref?.child("entries").childByAutoId().key
            let entry = [
                "title": entryTitle.text,
                "content": entryContent.text
            ]
            let childUpdates = [ "/entries/\(key)": entry]
            ref?.updateChildValues(childUpdates)
            print("successfully saved")
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

