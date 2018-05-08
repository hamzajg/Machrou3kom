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

        // Do any additional setup after loading the view.
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
                self.performSegue(withIdentifier: "showSignInPage", sender: self)
            }
        }
    }
    

}
