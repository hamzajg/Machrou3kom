//
//  Post.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-04-29.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import Foundation
import FirebaseDatabase

class Post {
    let itemRef: DatabaseReference!
    let itemKey: String!
    let adresse: String!
    let category_country: String!
    let createdAt: Date!
    let description:String!
    let idCategory: String!
    let idCountry:String!
    let like: String!
    let numTel:String!
    let photos: [String]!
    let post_owner:String!
    let title:String!
    let typePost:String!
    
    init () {
        self.itemRef = nil
        self.itemKey = ""
        self.adresse = ""
        self.category_country = ""
        self.createdAt = Date()
        self.description = ""
        self.idCategory = ""
        self.idCountry = ""
        self.like = ""
        self.numTel = ""
        self.photos = []
        self.post_owner = ""
        self.title = ""
        self.typePost = ""
    }
    
    init (snapshot:DataSnapshot) {
        self.itemRef = snapshot.ref
        self.itemKey = snapshot.key
        if let addr = snapshot.childSnapshot(forPath:"adresse").value as? String {
            self.adresse = addr
        } else {
            self.adresse = ""
        }
        if let title = snapshot.childSnapshot(forPath:"title").value as? String {
            self.title = title
        } else {
            self.title = ""
        }
        self.photos = []
        for p in snapshot.childSnapshot(forPath:"photos").children {
            if let photo = (p as! DataSnapshot).childSnapshot(forPath:"url").value as? String {
                photos.append(photo)
            }
        }
        if let typePost = snapshot.childSnapshot(forPath:"typePost").value as? String {
            self.typePost = typePost
        } else {
            self.typePost = ""
        }
        
        self.category_country = ""
        self.createdAt = Date()
        self.description = ""
        self.idCategory = ""
        self.idCountry = ""
        self.like = ""
        self.numTel = ""
        self.post_owner = ""
    }
    
    func getOnePhoto() -> String? {
        if(self.photos != nil && self.photos.count > 0) {
            return self.photos[0]
        } else {
            return nil
            
        }
    }
 }
