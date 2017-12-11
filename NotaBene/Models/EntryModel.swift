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
    var image: String?

    init(id: String?, entryTitle: String?, entryContent: String?, image: String?) {
        self.id = id;
        self.entryTitle = entryTitle;
        self.entryContent = entryContent;
        self.image = image;
    }

}

