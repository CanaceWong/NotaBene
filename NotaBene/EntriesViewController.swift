//
//  Entries.swift
//  NotaBene
//
//  Created by Olivia Beresford on 06/12/2017.
//  Copyright © 2017 NotaBeneTeam. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class Entries: UITableViewController {
    
    var refEntries: DatabaseReference!
    @IBOutlet var entriesTable: UITableView!
    
    var entriesList = [EntryModel]()
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entry = entriesList[indexPath.row]
        
        let alertController = UIAlertController(title: entry.entryTitle, message:"Edit/Delete?", preferredStyle:.alert)
        
        let updateAction = UIAlertAction(title:"Update", style:.default){(_) in
            let id = entry.id
            
            let entryTitle = alertController.textFields?[0].text
            let entryContent = alertController.textFields?[1].text
            
            self.updateEntry(id: id!, entryTitle: entryTitle!, entryContent: entryContent!)
        }
        
        let deleteAction = UIAlertAction(title:"Delete", style:.default){(_) in
        }
        
        alertController.addTextField{(textField) in
            textField.text = entry.entryTitle
        }
        
        alertController.addTextField{(textField) in
            textField.text = entry.entryContent
        }
        
        alertController.addAction(updateAction)
        alertController.addAction(deleteAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    func updateEntry(id: String, entryTitle: String, entryContent: String){
        let entry = [
            "id": id,
            "entryTitle": entryTitle,
            "entryContent": entryContent
        ]
        refEntries.child(id).setValue(entry)
//        labelMessage.text = "Entry Updated!"
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entriesList.count
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell
        
        let entry: EntryModel
        
        entry = entriesList[indexPath.row]
        
        cell.entryTitleLabel.text = entry.entryTitle
        cell.entryContentLabel.text = entry.entryContent
        
        return cell
    }
    
    @IBOutlet weak var userNameDisplay: UILabel!
    @IBAction func action(_ sender: UIButton) {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "logged2", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userNameDisplay.text = Auth.auth().currentUser?.email
        
        refEntries = Database.database().reference().child("entries");
        
        refEntries.observe(DataEventType.value, with:{(snapshot) in
            if snapshot.childrenCount>0{
                self.entriesList.removeAll()
                
                for entries in snapshot.children.allObjects as![DataSnapshot]{
                    let entryObject = entries.value as? [String: AnyObject]
                    let entryTitle = entryObject?["entryTitle"]
                    let entryContent = entryObject?["entryContent"]
                    let entryId = entryObject?["id"]
                    
                    let entry = EntryModel(id: entryId as! String?, entryTitle: entryTitle as! String?, entryContent: entryContent as! String?)
                    
                    self.entriesList.append(entry)
                }
                self.entriesTable.reloadData()
            }
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
