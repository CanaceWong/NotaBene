//
//  EntryModel.swift
//  NotaBene
//
//  Created by Christine Horrocks on 07/12/2017.
//  Copyright © 2017 NotaBeneTeam. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

class EntryModel {
    
    var id: String?
    var entryTitle: String?
    var entryContent: String?

    init(id: String?, entryTitle: String?, entryContent: String?) {
        self.id = id;
        self.entryTitle = entryTitle;
        self.entryContent = entryContent;
    }

    
    
//    let id: String
//    let entryTitle: String
//    let entryContent: String
//    let addedByUser: String
//    let ref: DatabaseReference?
//
//    init(id: String, entryTitle: String, entryContent: String, addedByUser: String) {
//        self.id = id;
//        self.entryTitle = entryTitle;
//        self.entryContent = entryContent;
//        self.addedByUser = addedByUser;
//        self.ref = nil;
//    }
//
//    init(snapshot: DataSnapshot) {
//        id = snapshot.key
//        let snapshotValue = snapshot.value as! [String: AnyObject]
//        entryTitle = snapshotValue["entryTitle"] as! String
//        entryContent = snapshotValue["entryContent"] as! String
//        addedByUser = snapshotValue["addedByUser"] as! String
//        ref = snapshot.ref
//    }
//
//    func toAnyObject() -> Any {
//        return [
//            "entryTitle": entryTitle,
//            "entryContent": entryContent,
//            "addedByUser": addedByUser
//        ]
//    }
}

