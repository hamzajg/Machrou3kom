//
//  Notification.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-05-06.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Notification {
    let idNotification: String!
    let body:String!
    let title:String!
    let userKey:String!
    
    init() {
        self.idNotification = nil
        self.body = nil
        self.title = nil
        self.userKey = nil
    }
    
    init (snapshot:DataSnapshot) {
        idNotification = snapshot.key
        if let body = snapshot.childSnapshot(forPath:"body").value as? String {
            self.body = body
        } else {
            self.body = ""
        }
        if let title = snapshot.childSnapshot(forPath:"title").value as? String {
            self.title = title
        } else {
            self.title = ""
        }
        if let userKey = snapshot.childSnapshot(forPath:"userKey").value as? String {
            self.userKey = userKey
        } else {
            self.userKey = ""
        }
    }
}
