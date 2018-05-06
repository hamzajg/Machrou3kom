//
//  AppServices.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-04-29.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

class AppServices {
    
    var ref:DatabaseReference?
    
    func GetAllPostsAsync(completed: @escaping ([Post]) -> ()){
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
    func GetAllCountriesAsync(completed: @escaping ([Country]) -> ()){
        var countries = [Country]()
        DispatchQueue.main.async {
            self.ref = Database.database().reference()
            self.ref?.child("Countries").observeSingleEvent(of: .value, with: {(snapshot) in
                for c in snapshot.children {
                    let country = Country(snapshot: c as! DataSnapshot)
                    countries.append(country)
                }
                completed(countries)
            })
        }
    }
    func GetAllNotificationsByUserAsync(user_sub:String!,completed: @escaping ([Notification]) -> ()){
        var notifications = [Notification]()
        DispatchQueue.main.async {
            self.ref = Database.database().reference()
            self.ref?.child("notifications").observeSingleEvent(of: .value, with: {(snapshot) in
                for n in snapshot.children {
                    if (n as! DataSnapshot).childSnapshot(forPath: "userKey").value as? String == user_sub {
                        let notification = Notification(snapshot: n as! DataSnapshot)
                        notifications.append(notification)
                    }
                }
                completed(notifications)
            })
        }
    }
    func GetAllPostsByIdCategoryAndIdCountryAsync(idCategory:String!, idCountry:String!, completed: @escaping ([Post]) -> ()){
        var posts = [Post]()
        DispatchQueue.main.async {
            self.ref = Database.database().reference()
            self.ref?.child("Posts").observeSingleEvent(of: .value, with: {(snapshot) in
                for p in snapshot.children {
                    if (p as! DataSnapshot).childSnapshot(forPath: "idCategory").value as? String == idCategory &&
                        (p as! DataSnapshot).childSnapshot(forPath: "idCountry").value as? String == idCountry {
                        let post = Post(snapshot: p as! DataSnapshot)
                        posts.append(post)
                    }
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
    
    func uploadFileToStorage(sub:String, uploadData:Data?) {
        print(String(Date().hashValue))
        let storageRef = Storage.storage().reference().child("images").child(String(Date().hashValue) + ".png")
        storageRef.putData(uploadData!, metadata: nil, completion: {(metadata, error) in
            if error != nil {
            print(error)
            return
            }
            print(metadata)
            var url = "https://firebasestorage.googleapis.com/v0/b/" + (metadata?.bucket)! + "/o/images/" + (metadata?.name)! + "?alt=media&token=" + metadata?.downloadTokens;
            
            print(url)
        })
        /*ref = Database.database().reference()
        self.ref?.child("Posts").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChild(sub) {
                self.ref?.child("Posts").child("photos").setValue(["" : ""])
            }
        })*/
    }
    
}
