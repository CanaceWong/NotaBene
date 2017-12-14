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
import BSImagePicker
import Photos

class Entry: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UNUserNotificationCenterDelegate {
  
    @IBOutlet weak var entryTitle: UITextField!
    @IBOutlet weak var entryContent: UITextView!
    @IBOutlet weak var successMessage: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var refEntries: DatabaseReference!
    var ref: DatabaseReference!
    var entriesList = [EntryModel]()
    var imageFileName = ""

    func addEntry() {

        lengthenImageFileName()
        print(self.imageFileName)
        
        let key = refEntries.childByAutoId().key
        let entry = [
            "id": key,
            "entryTitle": entryTitle.text! as String,
            "entryContent": entryContent.text! as String,
            "image": imageFileName
            ] as [String : Any]
            let dbref = Database.database().reference().child("users")
            let user = Auth.auth().currentUser
            if let uid = user?.uid {
            dbref.child("\(uid)").child("entries").child(key).setValue(entry)
            }
    }
    
    func lengthenImageFileName() {
        self.imageFileName.append(" , ")
        self.imageFileName.append(" , ")
        self.imageFileName.append(" , ")
        self.imageFileName.append(" , ")
    }
    
    @IBAction func saveEntry(_ sender: UIButton) {
        addEntry()
        scheduleNotification()
        scheduleSecondNotification()
    }
    
    
    //first Notification
    var datePickerView:UIDatePicker = UIDatePicker()
    
    @IBOutlet weak var dateTextField: UITextField!
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
        let key = entryTitle.text!
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
    // ends first Notification
    
    //second Notification
    var secondDatePickerView:UIDatePicker = UIDatePicker()
    @IBOutlet weak var secondDateTextField: UITextField!
    
    @IBAction func secondTextFieldEditing(_ sender: UITextField) {
        secondDatePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        sender.inputView = secondDatePickerView
        secondDatePickerView.addTarget(self, action: #selector(Entry.secondDatePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @objc func secondTappedToolBarBtn(sender: UIBarButtonItem) {
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = DateFormatter.Style.medium
        dateformatter.timeStyle = DateFormatter.Style.short
        secondDateTextField.text = dateformatter.string(from: NSDate() as Date)
        secondDateTextField.resignFirstResponder()
    }
    
    @objc func secondDatePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.short
        secondDateTextField.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func secondDonePressed(sender: UIBarButtonItem) {
        secondDateTextField.resignFirstResponder()
    }
    
    func scheduleSecondNotification() {
        let user = Auth.auth().currentUser
        let uid = user?.uid
        let refEntries = Database.database().reference().child("users").child("\(uid)").child("entries")
        let key = refEntries.childByAutoId().key
        let content = UNMutableNotificationContent() //The notification's content
        let datePicker = secondDatePickerView
        
        content.title = "Another reminder to review " + entryTitle.text!
        content.sound = UNNotificationSound.default()
        
        let dateComponent = datePicker.calendar.dateComponents([.day, .hour, .minute], from: datePicker.date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponent, repeats: false)
        let notificationReq = UNNotificationRequest(identifier: key, content: content, trigger: trigger)
        UNUserNotificationCenter.current().add(notificationReq, withCompletionHandler: nil)
    }
    //ends second Notification
    
    
    var SelectedImages = [PHAsset]()
    var PhotoArray = [UIImage]()
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        if (gesture.view as? UIImageView) != nil {
            print("Image Tapped")
            
            let vc = BSImagePickerViewController()
            self.bs_presentImagePickerController(vc, animated: true, select: { (asset: PHAsset) -> Void in
            }, deselect: { (asset: PHAsset) -> Void in
            }, cancel: { (assets: [PHAsset]) -> Void in
            }, finish: {(assets: [PHAsset]) -> Void in
                for i in 0..<assets.count{
                    self.SelectedImages.append(assets[i])
                }
                self.convertAssetToImages()
            }, completion: nil)
        }
    }
            
    
    
    func convertAssetToImages() -> Void {
        if SelectedImages.count != 0 {
            for i in 0..<SelectedImages.count{
                let manager = PHImageManager.default()
                let option = PHImageRequestOptions()
                var thumbnail = UIImage()
                option.isSynchronous = true
                manager.requestImage(for: SelectedImages[i], targetSize: CGSize(width: 200, height: 200), contentMode: .aspectFill, options: option, resultHandler: {(result, info)->Void in
                    thumbnail = result!
                })
                
                let data = UIImageJPEGRepresentation(thumbnail, 0.7)
                let newImage = UIImage(data: data!)
                let randomName = randomStringWithLength(length: 10)
                let uploadRef = Storage.storage().reference().child("images/\(randomName).jpg")
                
                uploadRef.putData(data!, metadata: nil) { metadata, error in
                    if error == nil {
                        //success
                        print("Sucessfully uploaded image!")
                        self.imageFileName.append("\(randomName as String).jpg , ")
                    } else {
                        // error
                        print("Error uploading image: \(error?.localizedDescription)")
                    }
                }
                
                self.PhotoArray.append(newImage! as UIImage)
            }
            self.imageView.animationImages = self.PhotoArray
            self.imageView.animationDuration = 5.0
            self.imageView.startAnimating()
        }
        print("complete photo array \(self.PhotoArray)")
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
        
        func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
            let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
            let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
            let blue = CGFloat(rgbValue & 0xFF)/256.0
            
            return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
        }
        
        UNUserNotificationCenter.current().delegate = self as UNUserNotificationCenterDelegate
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(Entry.imageTapped(gesture:)))
        
        imageView.addGestureRecognizer(tapGesture)
        imageView.isUserInteractionEnabled = true
        
        refEntries = Database.database().reference().child("entries");
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
        
        //toolbar1
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 20.0, width: self.view.frame.size.width, height: self.view.frame.size.height/10))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-10.0)
//        toolBar.barStyle = UIBarStyle.default
        toolBar.tintColor = UIColorFromHex(rgbValue: 0x97A1FF)
        toolBar.backgroundColor = UIColor.white

        let okBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(Entry.donePressed))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Avenir-medium", size: 20)
        label.backgroundColor = UIColor.clear
        label.textColor = UIColorFromHex(rgbValue: 0x97A1FF)
        label.text = "Set a reminder date"
        label.textAlignment = NSTextAlignment.left
        let textBtn = UIBarButtonItem(customView: label)
        toolBar.setItems([textBtn,flexSpace,okBarBtn], animated: true)
        dateTextField.inputAccessoryView = toolBar
        //end of toolbar 1
        
        //toolbar2
        let secondToolBar = UIToolbar(frame: CGRect(x: 0, y: 20.0, width: self.view.frame.size.width, height: self.view.frame.size.height/10))
        secondToolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
//        secondToolBar.barStyle = UIBarStyle.blackTranslucent
        secondToolBar.tintColor = UIColorFromHex(rgbValue: 0x97A1FF)
        secondToolBar.backgroundColor = UIColor.white
        
        let secondOkBarBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(Entry.secondDonePressed))
        
//        let secondFlexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
//
        let secondLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        secondLabel.font = UIFont(name: "Avenir-medium", size: 20)
        secondLabel.backgroundColor = UIColor.clear
        secondLabel.textColor = UIColorFromHex(rgbValue: 0x97A1FF)
        secondLabel.text = "Set a second Reminder date"
        secondLabel.textAlignment = NSTextAlignment.left
        let secondTextBtn = UIBarButtonItem(customView: secondLabel)
        secondToolBar.setItems([secondTextBtn,flexSpace,secondOkBarBtn], animated: true)
        secondDateTextField.inputAccessoryView = secondToolBar
        //end of toolbar 2
        
        
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

