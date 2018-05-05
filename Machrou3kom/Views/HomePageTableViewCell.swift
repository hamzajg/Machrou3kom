//
//  HomePageTableViewCell.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-04-29.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import UIKit

class HomePageTableViewCell: UITableViewCell {

    @IBOutlet weak internal var homeImageView: UIImageView!
    
    @IBOutlet weak internal var titleLabel: UILabel!
    
    @IBOutlet weak internal var companyLabel: UILabel!
    
    @IBOutlet weak internal var locationLabel: UILabel!
    
    @IBAction internal func likeBtnAction(_ sender: UIButton){
        
        let defaults = UserDefaults.standard
        
        // Receive
        if let profile_sub = defaults.string(forKey: "profile_sub")
        {
            print(profile_sub)
            
            let appServices = AppServices()
            appServices.LikePoat(sub1: profile_sub, sub2: profile_sub)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
