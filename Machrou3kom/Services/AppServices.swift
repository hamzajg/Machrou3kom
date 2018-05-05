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
    
    func LikePoat(sub:String, id:Int) {
        ref = Database.database().reference()
        self.ref?.child("Posts").child(sub).setValue(["like": id])
    }
    
    func AddNewPoat(sub:String, post:Post) {
        ref = Database.database().reference()
        self.ref?.child("Posts").child(sub).setValue(post.toAnyObject())
    }
    
}
