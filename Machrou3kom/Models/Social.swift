//
//  Social.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-05-12.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Social {
    let idSocial:String!
    let image:String!
    let name:String!
    let url:String!
    
    init() {
        self.idSocial = nil
        self.image = nil
        self.name = nil
        self.url = nil
    }
    init (snapshot:DataSnapshot) {
        self.idSocial = snapshot.key
        if let url = snapshot.childSnapshot(forPath:"url").value as? String {
            self.url = url
        } else {
            self.url = ""
        }
        if let name = snapshot.childSnapshot(forPath:"name").value as? String {
            self.name = name
        } else {
            self.name = ""
        }
        if let image = snapshot.childSnapshot(forPath:"image").value as? String {
            self.image = image
        } else {
            self.image = ""
        }
    }
}
