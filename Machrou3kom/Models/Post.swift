//
//  Post.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-04-29.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import Foundation

class Post: Codable {
    var adresse: String = ""
    var category_country: String = ""
    var createdAt: Date = Date()
    var description:String = ""
    var idCategory: String = ""
    var idCountry:String = ""
    var like: String = ""
    var numTel:String = ""
    var photos: String = ""
    var post_owner:String = ""
    var title:String = ""
    var typePost:String = ""
}
