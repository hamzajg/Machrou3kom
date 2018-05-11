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
    let ads: [CountryAd]!
    
    init() {
        self.idCountry = nil
        self.name = nil
        self.photo = nil
        self.active = nil
        self.ads = [CountryAd]()
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
        self.ads = [CountryAd]()
        for a in snapshot.childSnapshot(forPath:"ads").children {
            let ad = CountryAd(snapshot: a as! DataSnapshot)
                ads.append(ad)
        }
    }
    
}
