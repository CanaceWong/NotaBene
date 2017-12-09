//
//  SetRemindViewController.swift
//  NotaBene
//
//  Created by Canace Lok Hay Wong on 08/12/2017.
//  Copyright © 2017 NotaBeneTeam. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import UserNotifications

class SetRemindViewController: UIViewController {
    
    var entry: KeyTitlePair?

    @IBOutlet weak var datePicker: UIDatePicker!
    
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

struct KeyTitlePair {
    var id: String
    var title: String
}
