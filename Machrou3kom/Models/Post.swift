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
    var like: [String: String]
    let numTel:Int
    let photos: [String]!
    let post_owner:String!
    let title:String!
    let typePost:String!
    
    init (itemRef:DatabaseReference!, itemKey: String!, adresse:String!, catagory_country:String!, description:String!, idCategory:String!,
          idCountry:String!, numTel:Int, title:String!, post_owner:String!, typePost:String!) {
        self.itemRef = itemRef
        self.itemKey = itemKey
        self.adresse = adresse
        self.category_country = catagory_country
        self.createdAt = Date()
        self.description = description
        self.idCategory = idCategory
        self.idCountry = idCountry
        self.like = [:]
        self.numTel = numTel
        self.photos = []
        self.post_owner = post_owner
        self.title = title
        self.typePost = typePost
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
        
        if let category_country = snapshot.childSnapshot(forPath:"category_country").value as? String {
            self.category_country = category_country
        } else {
            self.category_country = ""
        }
        if let createdAt = snapshot.childSnapshot(forPath:"createdAt").value as? Date {
            self.createdAt = createdAt
        } else {
            if let createdAt = snapshot.childSnapshot(forPath:"createdAt").value as? String {
                let df = DateFormatter()
                df.dateFormat = "dd MM yyyy hh:mm:ss +zzzz"
                self.createdAt = df.date(from: createdAt)
            } else {
                if let createdAt = snapshot.childSnapshot(forPath:"createdAt").value as? Int64 {
                    self.createdAt = Date(timeIntervalSince1970: (TimeInterval(createdAt / 1000)))
            } else {
                self.createdAt = Date()
                }
            }
        }
        if let description = snapshot.childSnapshot(forPath:"description").value as? String {
            self.description = description
        } else {
            self.description = ""
        }
        if let idCategory = snapshot.childSnapshot(forPath:"idCategory").value as? String {
            self.idCategory = idCategory
        } else {
            self.idCategory = ""
        }
        if let idCountry = snapshot.childSnapshot(forPath:"idCountry").value as? String {
            self.idCountry = idCountry
        } else {
            self.idCountry = ""
        }
        self.like = [:]
        for l in snapshot.childSnapshot(forPath:"like").children {
            like.updateValue(String((l as? DataSnapshot)?.value is Int16), forKey: ((l as? DataSnapshot)?.key)! )
        }
        
        if let numTel = snapshot.childSnapshot(forPath:"numTel").value as? Int {
            self.numTel = numTel
        } else {
            self.numTel = 00000000
        }
        self.post_owner = ""
    }
    
    func getOnePhoto() -> String? {
        if(self.photos != nil && self.photos.count > 0) {
            return self.photos[0]
        } else {
            return nil
            
        }
    }
    func getLikesCount() -> Int {
        return like.count
    }
    func isLiked() -> Bool {
        var resul:Bool = false
        let defaults = UserDefaults.standard
        // Receive
        if let profile_sub = defaults.string(forKey: "profile_sub")
        {
            for l in like {
                if l.key == profile_sub {
                    resul = true
                    break
                } else {
                    resul = false
                }
            }
        } else {
            resul = false
        }
        return resul
    }
    func toAnyObject() -> Dictionary<String, Any> {
        return ["adresse": self.adresse, "title": self.title, "numTel": self.numTel, "idCountry": self.idCountry, "idCategory": self.idCategory,
                "like": self.like, "category_country": self.category_country, "typePost": self.typePost, "photos": self.photos, 
                "post_owner": self.post_owner, "createdAt": self.createdAt.description ]
    }
 }
