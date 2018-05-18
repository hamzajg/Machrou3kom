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
                    if country.active {
                        countries.append(country)
                    }
                }
                completed(countries)
            })
        }
    }
    func GetOneCountryByIdCountryAsync(idCountry:String, completed: @escaping (Country?) -> ()){
        var country:Country?
        DispatchQueue.main.async {
            self.ref = Database.database().reference()
            self.ref?.child("Countries").observeSingleEvent(of: .value, with: {(snapshot) in
                country = Country(snapshot: snapshot.childSnapshot(forPath: idCountry))
                completed(country)
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
                posts = posts.sorted(by: {($0.getLikesCount() > $1.getLikesCount()) || $0.isAvailable()})
                completed(posts)
            })
        }
    }
    
    func GetAllSocialsAsync(completed: @escaping ([Social]) -> ()) {
        var socials = [Social]()
        DispatchQueue.main.async {
            self.ref = Database.database().reference()
            self.ref?.child("social").observeSingleEvent(of: .value, with: {(snapshot) in
                for s in snapshot.children {
                    let social = Social(snapshot: s as! DataSnapshot)
                    socials.append(social)
                }
                completed(socials)
            })
        }
    }
    
    func LikePost(sub1:String, sub2:String, completed: @escaping (Bool) -> ()) {
        var result:Bool = false
        ref = Database.database().reference()
        self.ref?.child("Posts").child(sub1).child("like").observeSingleEvent(of: .value, with: {(snapshot) in
            if !snapshot.childSnapshot(forPath: sub2).exists() {
                self.ref?.child("Posts").child(sub1).child("like").updateChildValues([sub2: Date().description])
                result = true
            } else {
                self.ref?.child("Posts").child(sub1).child("like").child(sub2).removeValue()
                result = false
            }
            completed(result)
        })
    }
    
    func AddNewPoat(sub:String, post:Post) {
        ref = Database.database().reference()
        self.ref?.child("Posts").observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.hasChild(sub) {
                self.ref?.child("Posts").child(sub).setValue(post.toAnyObject())
            } else {
                if let ep:Post! = Post(snapshot: snapshot.childSnapshot(forPath: sub)) {
                    if ep.title != post.title {
                        self.ref?.child("Posts").child(sub).child("title").setValue(post.title)
                    }
                    if ep.numTel != post.numTel {
                        self.ref?.child("Posts").child(sub).child("numTel").setValue(post.numTel)
                    }
                    if ep.adresse != post.adresse {
                        self.ref?.child("Posts").child(sub).child("adresse").setValue(post.adresse)
                    }
                    if ep.typePost != post.typePost {
                        self.ref?.child("Posts").child(sub).child("typePost").setValue(post.typePost)
                    }
                    if ep.description != post.description {
                        self.ref?.child("Posts").child(sub).child("description").setValue(post.description)
                    }
                    if ep.post_owner != post.post_owner {
                        self.ref?.child("Posts").child(sub).child("post_owner").setValue(post.post_owner)
                    }
                }
            }
        })
    }
    func AddNewUser(user:User) {
        ref = Database.database().reference()
        self.ref?.child("Users").observeSingleEvent(of: .value, with: { (snapshot) in
            if !snapshot.hasChild(user.idUser) {
                self.ref?.child("Users").child(user.idUser).setValue(user.toAnyObject())
            }
        })
    }
    func UpdateUser(user:User) {
        ref = Database.database().reference()
        self.ref?.child("Users").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChild(user.idUser) {
                self.ref?.child("Users").child(user.idUser).setValue(user.toAnyObject())
            }
        })
    }
    func GetOneUser(sub:String, completed: @escaping (User?) -> ()){
        var user:User?
        ref = Database.database().reference()
        self.ref?.child("Users").observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChild(sub) {
                user = User(snapshot: snapshot.childSnapshot(forPath: sub))
                }
                completed(user)
        })
    }
    func GetOnePostByUserAsync(sub:String, completed: @escaping (Post?) -> ()){
        var post:Post?
        DispatchQueue.main.async {
            self.ref = Database.database().reference()
            self.ref?.child("Posts").observeSingleEvent(of: .value, with: { (snapshot) in
                if snapshot.hasChild(sub) {
                    post = Post(snapshot: snapshot.childSnapshot(forPath: sub))
                    print(post)
                }
                completed(post)
            })
        }
    }
    func AddNewNotification(sub1:String, sub2:String) {
        ref = Database.database().reference()
        self.ref?.child("notifications").childByAutoId().setValue(["body":"تحصل إعلانك على إعجاب جديد", "title":"أعجب أحدهم بإعلانك","type": "like","time":Date().timeIntervalSince1970, "userKey":sub1.replacingOccurrences(of: "|", with: "", options: .literal, range: nil)])
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
            self.ref = Database.database().reference()
            self.ref?.child("Posts").observeSingleEvent(of: .value, with: { (snapshot) in
                if snapshot.hasChild(sub) {
                    self.ref?.child("Posts").child(sub).child("photos").childByAutoId().setValue(["url" : metadata?.downloadURL()?.absoluteString])
                }
            })
        })
    }
    
}
