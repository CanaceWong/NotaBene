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
    @IBOutlet weak var dateTextField: UITextField!
    
    @IBAction func textFieldEditing(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(Entry.datePickerValueChanged), for: UIControlEvents.valueChanged)
        
    }

    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.none
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func donePressed(sender: UIBarButtonItem) {
        dateTextField.resignFirstResponder()
    }
    
    @objc func tappedToolBarBtn(sender: UIBarButtonItem) {
        
        let dateformatter = DateFormatter()
        
        dateformatter.dateStyle = DateFormatter.Style.medium
        
        dateformatter.timeStyle = DateFormatter.Style.none
        
        dateTextField.text = dateformatter.string(from: NSDate() as Date)
        
        dateTextField.resignFirstResponder()
    }
    
    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    
        refEntries = Database.database().reference().child("entries");
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 40.0, width: self.view.frame.size.width, height: self.view.frame.size.height/6))
        
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.blackTranslucent
        
        toolBar.tintColor = UIColor.white
        
        toolBar.backgroundColor = UIColor.black
        
        
        let todayBtn = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.plain, target: self, action: #selector(Entry.tappedToolBarBtn))
        
        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(Entry.donePressed))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Helvetica", size: 12)
        
        label.backgroundColor = UIColor.clear
        
        label.textColor = UIColor.white
        
        label.text = "Set a Reminder Date"
        
        label.textAlignment = NSTextAlignment.center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([todayBtn,flexSpace,textBtn,flexSpace,okBarBtn], animated: true)
        
        dateTextField.inputAccessoryView = toolBar
        
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
