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
import UserNotifications

class Entries: UITableViewController {
    
    
    @IBOutlet var entriesTable: UITableView!
    
    var refEntries: DatabaseReference!
    var entriesList = [EntryModel]()
    var entry: EntryModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentUser = Auth.auth().currentUser
        userNameDisplay.text = currentUser?.email
        
        let refEntries = Database.database().reference().child("users")
        if let uid = currentUser?.uid {
            
            refEntries.child("\(uid)").child("entries").observe(DataEventType.value, with:{(snapshot) in
                if snapshot.childrenCount>0{
                    self.entriesList.removeAll()
                    
                    for entries in snapshot.children.allObjects as![DataSnapshot]{
                        let entryObject = entries.value as? [String: Any] ?? [:]
                        let entryTitle = entryObject["entryTitle"]
                        let entryContent = entryObject["entryContent"]
                        let entryId = entryObject["id"]
                        let images = entryObject["image"]
                       print(images)
                        
                        let entry = EntryModel(id: entryId as! String?, entryTitle: entryTitle as! String?, entryContent: entryContent as! String?, image: images as? String)
                       
                        self.entriesList.append(entry)
                    }
                    self.entriesTable.reloadData()
                }
            })
        }
    }
    
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return entriesList.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEntry" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let destination = segue.destination as! ShowEntryViewController
                destination.entry = entriesList[indexPath.row]
            }
        }
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
    
    
    @IBAction func logout(_ sender: UIButton) {
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
                let logout: UIViewController? = self.storyboard?.instantiateViewController(withIdentifier: "Home")
                self.present(logout!, animated: true, completion: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
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
