//
//  CountryAd.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-05-11.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import Foundation
import FirebaseDatabase

class CountryAd {
    let idAd: String!
    let img: String!
    let link: String!
    let time:Int64!
    
    init() {
        self.idAd = nil
        self.img = nil
        self.link = nil
        self.time = nil
    }
    
    init (snapshot:DataSnapshot) {
        idAd = snapshot.key
        
        if let img = snapshot.childSnapshot(forPath:"img").value as? String {
            self.img = img
        } else {
            self.img = ""
        }
        if let link = snapshot.childSnapshot(forPath:"link").value as? String {
            self.link = link
        } else {
            self.link = ""
        }
        if let time = snapshot.childSnapshot(forPath:"time").value as? Int64 {
            self.time = time
        } else {
            self.time = 0
        }
    }
    
}
