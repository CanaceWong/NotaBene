//
//  EntryModel.swift
//  NotaBene
//
//  Created by Christine Horrocks on 07/12/2017.
//  Copyright © 2017 NotaBeneTeam. All rights reserved.
//

import Foundation
import FirebaseAuth

class EntryModel {
    
    var id: String?
    var entryTitle: String?
    var entryContent: String?

    init(id: String?, entryTitle: String?, entryContent: String?) {
        self.id = id;
        self.entryTitle = entryTitle;
        self.entryContent = entryContent;
    }

}

