//
//  PostViewController.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-05-05.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postTypeLabel: UILabel!
    @IBOutlet weak var postLocationLabel: UILabel!
    @IBOutlet weak var postPhoneNumberLabel: UILabel!
    @IBOutlet weak var postDescLabel: UILabel!
    @IBOutlet weak var postPostedAtLabel: UILabel!
    @IBOutlet weak var postLikesCountLabel: UILabel!
    var post:Post! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        if post != nil {
            self.title = post.title
            postTitleLabel.text = post.title
            postTypeLabel.text = post.typePost
            postLocationLabel.text = post.adresse
            postPhoneNumberLabel.text = post.numTel
            postPostedAtLabel.text = post.createdAt.description
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
