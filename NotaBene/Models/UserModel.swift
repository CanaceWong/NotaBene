//
//  UserModel.swift
//  NotaBene
//
//  Created by Olivia Beresford on 08/12/2017.
//  Copyright © 2017 NotaBeneTeam. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

struct User {
    
    let uid: String
    let email: String
    
    init(authData: User) {
        uid = authData.uid
        email = authData.email
    }
    
    init(uid: String, email: String) {
        self.uid = uid
        self.email = email
    }
    
}
