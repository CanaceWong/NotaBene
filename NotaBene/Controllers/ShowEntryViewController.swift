//
//  ShowEntryViewController.swift
//  NotaBene
//
//  Created by Olivia Beresford on 07/12/2017.
//  Copyright © 2017 NotaBeneTeam. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class ShowEntryViewController: UIViewController {
    
    
    @IBOutlet weak var entryTitleDisplay: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let entryReference = Database.database().reference().child("entries").child("-L-qFiFStLfdwwgagOPw")
        entryReference.observeSingleEvent(of: DataEventType.value, with: {(snapshot) in
            let entry = snapshot.value as? [String: AnyObject]
            
            self.entryTitleDisplay.text = entry?["entryTitle"] as? String ?? ""
        })
        
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
