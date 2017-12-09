//
//  EntryViewController.swift
//  NotaBene
//
//  Created by Olivia Beresford on 06/12/2017.
//  Copyright © 2017 NotaBeneTeam. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class Entry: UIViewController {
    
    
    @IBOutlet weak var entryTitle: UITextField!
    @IBOutlet weak var entryContent: UITextField!
    @IBOutlet weak var successMessage: UILabel!
    
    var refEntries: DatabaseReference!
    var ref: DatabaseReference!
    var entriesList = [EntryModel]()
    
    @IBAction func saveEntry(_ sender: UIButton) {
        addEntry()
    }
    
    
    func addEntry() {
        let key = refEntries.childByAutoId().key

        let entry = [
                    "id": key,
                    "entryTitle": entryTitle.text! as String,
                    "entryContent": entryContent.text! as String
        ]

        refEntries.child(key).setValue(entry)

        successMessage.text = "Entry Saved!"
    }

    
//    func addEntry() {
//        let key = refEntries.childByAutoId().key
//        let userKey = ref.child("users").childByAutoId().key
//        let entry = [ "uid": userKey,
//                      "id": key,
//                      "entryTitle": entryTitle.text! as String,
//                      "entryContent": entryContent.text! as String
//        ]
//        let childUpdates = ["/entries/\(key)": entry,
//                            "user-entries/\(userKey)/\(key)/": entry]
//        ref.updateChildValues(childUpdates)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    
        refEntries = Database.database().reference().child("entries");
        
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

