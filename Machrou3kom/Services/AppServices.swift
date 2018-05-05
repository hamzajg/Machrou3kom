//
//  AppServices.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-04-29.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import Foundation
import FirebaseDatabase

class AppServices {
    
    var ref:DatabaseReference?
    
    func GetAllPostAsync(completed: @escaping ([Post]) -> ()){
        var posts = [Post]()
        DispatchQueue.main.async {
            self.ref = Database.database().reference()
            self.ref?.child("Posts").observeSingleEvent(of: .value, with: {(snapshot) in
                for p in snapshot.children {
                    let post = Post(snapshot: p as! DataSnapshot)
                    posts.append(post)
                }
                completed(posts)
            })
        }
    }
    
    func LikePoat(sub1:String, sub2:String) {
        ref = Database.database().reference()
        self.ref?.child("Posts").child(sub1).child("like").setValue([sub2: Date().description])
    }
    
    func AddNewPoat(sub:String, post:Post) {
        ref = Database.database().reference()
        self.ref?.child("Posts").observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.hasChild(sub) {
                self.ref?.child("Posts").child(sub).setValue(post.toAnyObject())
            }
        })
    }
    func GetAllCategoriesAsync(completed: @escaping ([Category]) -> ()){
        var categories = [Category]()
        DispatchQueue.main.async {
            self.ref = Database.database().reference()
            self.ref?.child("Categories").observeSingleEvent(of: .value, with: {(snapshot) in
                for c in snapshot.children {
                    let category = Category(snapshot: c as! DataSnapshot)
                    categories.append(category)
                }
                completed(categories)
            })
        }
    }
    
}
