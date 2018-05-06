//
//  Country.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-05-06.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Country {
    let idCountry: String!
    let name: String!
    let photo: String!
    let active: Bool!
    let ads: [Any]
    
    init() {
        self.idCountry = nil
        self.name = nil
        self.photo = nil
        self.active = nil
        self.ads = [Any]()
    }
    
    init(snapshot:DataSnapshot) {
        self.idCountry = snapshot.key
        if let name = snapshot.childSnapshot(forPath:"name").value as? String {
            self.name = name
        } else {
            self.name = ""
        }
        if let photo = snapshot.childSnapshot(forPath:"photo").value as? String {
            self.photo = photo
        } else {
            self.photo = ""
        }
        if let active = snapshot.childSnapshot(forPath:"active").value as? Bool {
            self.active = active
        } else {
            self.active = nil
        }
        self.ads = [Any]()
    }
    
}
