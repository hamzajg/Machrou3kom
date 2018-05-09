//
//  User.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-05-08.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import Foundation
import FirebaseDatabase

class User {
    let idUser: String!
    let full_name:String!
    let profile_picture:String!
    
    init() {
        self.idUser = nil
        self.full_name = nil
        self.profile_picture = nil
    }
    init(idUser:String!, full_name:String!, profile_picture:String!) {
        self.idUser = idUser
        self.full_name = full_name
        self.profile_picture = profile_picture
    }
    
    init (snapshot:DataSnapshot) {
        idUser = snapshot.key
        if let full_name = snapshot.childSnapshot(forPath:"full_name").value as? String {
            self.full_name = full_name
        } else {
            self.full_name = ""
        }
        if let profile_picture = snapshot.childSnapshot(forPath:"profile_picture").value as? String {
            self.profile_picture = profile_picture
        } else {
            self.profile_picture = ""
        }
    }
    func toAnyObject() -> Dictionary<String, Any> {
        return ["full_name": self.full_name, "profile_picture": self.profile_picture]
    }
}
