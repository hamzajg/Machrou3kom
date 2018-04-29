//
//  ChooseCountryViewController.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-04-29.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import UIKit

class ChooseCountryViewController: UIViewController {
    
    @IBAction func bahrainBtnAction(_ sender: UIButton) {
        print("bahrainBtnAction")
        let defaults = UserDefaults.standard
        
        // Store
        defaults.set("bahrain", forKey: "country")
        
        // Receive
        if let name = defaults.string(forKey: "country")
        {
            print(name)
            self.performSegue(withIdentifier: "goHomePage", sender: self)
        }
    }
    @IBAction func saudiArabiaBtnAction(_ sender: UIButton) {
        print("saudiArabiaBtnAction")
    }
    @IBAction func qatarBtnAction(_ sender: UIButton) {
        print("qatarBtnAction")
    }
    @IBAction func kowaitBtnAction(_ sender: UIButton) {
        print("kowaitBtnAction")
    }
    @IBAction func jordanBtnAction(_ sender: UIButton) {
        print("jordanBtnAction")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
