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
    @IBOutlet weak var userNameTextField: UITextField!
    @IBAction func changeCountryBtnAction(_ sender: UIButton) {
    }
    @IBAction func saveChangesBtnAction(_ sender: UIButton) {
            
            let defaults = UserDefaults.standard
            
            // Receive
            if let profile_sub = defaults.string(forKey: "profile_sub")
            {
                let appServices = AppServices()
                do {
                    try appServices.UpdateUser(user: User(idUser: profile_sub, full_name: userNameTextField.text, profile_picture: ""))
                    let alert = UIAlertController(title: self.title, message: "تم حفظ التغييرات بنجاح", preferredStyle: .alert)
                    
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    
                    self.present(alert, animated: true)
            } catch {
                
                let alert = UIAlertController(title: self.title, message: "خطأ في حفظ التغييرات", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                
                self.present(alert, animated: true)
            }
            }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if ViewController.isGuest {
            dismiss(animated: true, completion: nil)
        } else {
            let defaults = UserDefaults.standard
            
            // Receive
            if let profile_sub = defaults.string(forKey: "profile_sub")
            {
                
                let appServices = AppServices()
                appServices.GetOneUser(sub: profile_sub) {(user) in
                    let u = (user)
                    if u != nil {
                        self.userNameTextField.text = u!.full_name
                    } else {
                        self.userNameTextField.text = profile_sub
                    }
                }
            }
        }
        // Do any additional setup after loading the view.
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
