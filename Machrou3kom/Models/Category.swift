//
//  Category.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-05-05.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Category {
    let idCategory: String!
    let name: String!
    let photo: String!
    var subCategories: [Category]
    
    init() {
        self.idCategory = nil
        self.name = nil
        self.photo = nil
        self.subCategories = [Category]()
    }
    
    init(snapshot:DataSnapshot) {
        self.idCategory = snapshot.key
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
        self.subCategories = [Category]()
        for c in snapshot.childSnapshot(forPath:"subCategories").children {
            let category = Category(snapshot: c as! DataSnapshot)
            self.subCategories.append(category)
        }
    }
    
}
