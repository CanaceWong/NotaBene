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
    
    var entry: EntryModel?
    var entriesList = [EntryModel]()
    var refEntries = Database.database().reference().child("entries")
    var ref = Database.database().reference()
    
    @IBOutlet weak var entryContentEditable: UITextView!
    @IBOutlet weak var entryTitleEditable: UITextField!
    
    
    @IBAction func deleteButton(_ sender: Any) {
        self.deleteEntry(id: (entry?.id!)!)
    }
    
    @IBAction func saveChanges(_ sender: Any) {
        let id = entry?.id
        self.updateEntry(id: id!, entryTitle: entryTitleEditable.text!, entryContent: entryContentEditable.text!)
        print("success")
    }
    
    func updateEntry(id: String, entryTitle: String, entryContent: String){
            let entry = [
                "id": id,
                "entryTitle": entryTitle,
                "entryContent": entryContent
            ]
            refEntries.child(id).setValue(entry)
    }
    
    func deleteEntry(id: String) {
        refEntries.child(id).setValue(nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entryTitleEditable.text = entry?.entryTitle
        entryContentEditable.text = entry?.entryContent
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
