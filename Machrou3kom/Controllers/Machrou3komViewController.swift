//
//  Machrou3komViewController.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-05-08.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import UIKit

class Machrou3komViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        addNavBarImageView()
        // Do any additional setup after loading the view.
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
//        let backButton = UIBarButtonItem(title: "", style: .plain, target: navigationController, action: nil)
//        navigationItem.leftBarButtonItem = backButton
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "goNewPostPage" {
            if ViewController.isGuest {
                
                let alert = UIAlertController(title: self.title, message: "يجب عليك تسجيل الدخول لاستخدام هذه الخاصية", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "حسنا", style: .default, handler: {(action:UIAlertAction!) in
                    self.performSegue(withIdentifier: "showSignInPage", sender: self)
                }))
                alert.addAction(UIAlertAction(title: "لا أريد", style: .cancel, handler: nil))
                
                self.present(alert, animated: true)
            }
        }
    }
    

}
