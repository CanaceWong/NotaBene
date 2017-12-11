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
import FirebaseStorage
import UserNotifications


class Entry: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UNUserNotificationCenterDelegate {
  
    @IBOutlet weak var entryTitle: UITextField!
    @IBOutlet weak var entryContent: UITextField!
    @IBOutlet weak var successMessage: UILabel!
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var imageView: UIImageView!    
    var refEntries: DatabaseReference!
    var ref: DatabaseReference!
    var entriesList = [EntryModel]()
    var datePickerView:UIDatePicker = UIDatePicker()
    var imageFileName = ""

    
    func addEntry() {
        let key = refEntries.childByAutoId().key
        let entry = [
            "id": key,
            "entryTitle": entryTitle.text! as String,
            "entryContent": entryContent.text! as String,
            "image": imageFileName
        ]
            let dbref = Database.database().reference().child("users")
            let user = Auth.auth().currentUser
            if let uid = user?.uid {
            dbref.child("\(uid)").child("entries").child(key).setValue(entry)
            }
    }
    
    @IBAction func saveEntry(_ sender: UIButton) {
        addEntry()
        scheduleNotification()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert,.sound])
    }
    
    
    @IBAction func textFieldEditing(_ sender: UITextField) {
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(Entry.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.short
        dateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    func scheduleNotification() {
        let user = Auth.auth().currentUser
        let uid = user?.uid
        refEntries = Database.database().reference().child("users").child("\(uid)").child("entries")
        let key = refEntries.childByAutoId().key
        let content = UNMutableNotificationContent() //The notification's content
        let datePicker = datePickerView

        content.title = "It is time to review " + entryTitle.text!
        content.sound = UNNotificationSound.default()

        let dateComponent = datePicker.calendar.dateComponents([.day, .hour, .minute], from: datePicker.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        let notificationReq = UNNotificationRequest(identifier: key, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(notificationReq, withCompletionHandler: nil)
    }
  
  
    @objc func donePressed(sender: UIBarButtonItem) {
        dateTextField.resignFirstResponder()
    }
    
    @objc func tappedToolBarBtn(sender: UIBarButtonItem) {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = DateFormatter.Style.medium
        dateformatter.timeStyle = DateFormatter.Style.short
        dateTextField.text = dateformatter.string(from: NSDate() as Date)
        dateTextField.resignFirstResponder()
    }
    
    func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) != nil {
            print("Image Tapped")
            
            let image = UIImagePickerController()
            image.delegate = self
            image.sourceType = UIImagePickerControllerSourceType.photoLibrary
            image.allowsEditing = true
            self.present(image, animated: true)
            {
                //After it is complete
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImageFromPicker: UIImage?
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            selectedImageFromPicker = editedImage
        } else if let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        if let selectedImage = selectedImageFromPicker {
            imageView.image = selectedImage
        }
        else
        {
            //Error message
            print("All is doomed! Your image has failed")
        }
        
        uploadImage(image: selectedImageFromPicker!)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func uploadImage(image: UIImage) {
        let randomName = randomStringWithLength(length: 10)
        let imageData = UIImageJPEGRepresentation(image, 1.0)
        let uploadRef = Storage.storage().reference().child("images/\(randomName).jpg")
        
        let uploadTask = uploadRef.putData(imageData!, metadata: nil) { metadata, error in
            if error == nil {
                //success
                print("Sucessfully uploaded image!")
                self.imageFileName = "\(randomName as String).jpg"
            } else {
                // error
                print("Error uploading image: \(error?.localizedDescription)")
            }
        }
    }
    
    func randomStringWithLength(length: Int) -> NSString {
        let characters: NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let randomString: NSMutableString = NSMutableString(capacity: length)
        
        for i in 0..<length {
            let len = UInt32(characters.length)
            let rand = arc4random_uniform(len)
            randomString.appendFormat("%C", characters.character(at: Int(rand)))
        }
        
        return randomString
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(Entry.imageTapped(gesture:)))
        
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        
        refEntries = Database.database().reference().child("entries");
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
        
//        let user = Auth.auth().currentUser
//        let uid = user?.uid
//        let refEntries = Database.database().reference().child("users").child("\(uid)").child("entries")
        
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 40.0, width: self.view.frame.size.width, height: self.view.frame.size.height/6))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        toolBar.barStyle = UIBarStyle.blackTranslucent
        toolBar.tintColor = UIColor.white
        toolBar.backgroundColor = UIColor.white
        
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

