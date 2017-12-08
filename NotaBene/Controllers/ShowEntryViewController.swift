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
    
    
//    func deleteEntry(id: String) {
//        refEntries.child(id).setValue(nil)
//    }
//
//    func updateEntry(id: String, entryTitle: String, entryContent: String){
//        let entry = [
//            "id": id,
//            "entryTitle": entryTitle,
//            "entryContent": entryContent
//        ]
//        refEntries.child(id).setValue(entry)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // maybe we need this???
//        ref.observe(.value, with: { snapshot in
//            print(snapshot.value)})
        
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
