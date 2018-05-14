//
//  UserProfileViewController.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-05-05.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var updatePostBtn: UIButton!
    @IBOutlet weak var changeCountryBtn: UIButton!
    @IBOutlet weak var signOutBtn: UIButton!
    @IBAction func changeCountryBtnAction(_ sender: UIButton) {
    }
    func addNavBarImageView() {
        
        let navController = navigationController!
        let image = #imageLiteral(resourceName: "finalmashroukom-horiz-1")
        let imageView = UIImageView(image: image)
        
        let bannerWidth = navController.navigationBar.frame.size.width
        let bannerHeight = navController.navigationBar.frame.size.height
        
        let bannerX = bannerWidth / 2 - image.size.width / 2
        let bannerY = bannerHeight / 2 - image.size.height / 2
        
        imageView.frame = CGRect(x: bannerX, y: bannerY, width: bannerWidth, height: bannerHeight)
        imageView.contentMode = .scaleAspectFit
        navigationItem.titleView = imageView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarImageView()
        
        if ViewController.isGuest {
            userNameLabel.isHidden = true
            userProfileImageView.isHidden = true
            changeCountryBtn.isHidden = true
            updatePostBtn.isHidden = true
            signOutBtn.isHidden = true
            let viewController: ViewController = self.storyboard?.instantiateViewController(withIdentifier: "SingIn") as! ViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        } else if SessionManager.profile != nil {
            userNameLabel.isHidden = false
            userProfileImageView.isHidden = false
            changeCountryBtn.isHidden = false
            updatePostBtn.isHidden = false
            signOutBtn.isHidden = false
            userNameLabel.text = SessionManager.profile.name
            userProfileImageView.downloadedFrom(url: SessionManager.profile.picture!)
            userProfileImageView.layer.cornerRadius = userProfileImageView.frame.size.width / 2
            userProfileImageView.clipsToBounds = true
        }
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        viewDidLoad()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOutBtnAction(_ sender: UIButton) {
        ViewController.isGuest = false
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
