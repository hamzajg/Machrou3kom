//
//  ContactUsViewController.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-05-12.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import UIKit

class ContactUsViewController: UIViewController {

    @IBOutlet weak var vStackView: UIStackView!
    var socials:[Social]!
    override func viewDidLoad() {
        super.viewDidLoad()

        let appServices = AppServices()
        appServices.GetAllSocialsAsync() {(socials) in
            self.socials = (socials)
            self.vStackView.addArrangedSubview(UIButton(type: UIButtonType.custom))
            for s in self.socials {
                let btn = UIButton(type: UIButtonType.custom)
                btn.frame = CGRect(x: 0, y: 10, width: 150, height: 27)
                btn.restorationIdentifier = s.name
                btn.setTitle(" Mshro3com_app", for: .normal)
                btn.addTarget(self, action: #selector(self.openUrlLink(_:)), for: .touchUpInside)
                btn.layer.cornerRadius = 5
                btn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
                if s.name.lowercased() == "facebook" {
                    btn.backgroundColor = UIColor(red: 63/255, green: 81/255, blue: 181/255, alpha: 1)
                    btn.setImage(UIImage(named: s.name.lowercased() + "-25-colored"), for: .normal)
                } else if s.name.lowercased() == "twitter" {
                    btn.backgroundColor = UIColor(red: 29/255, green: 161/255, blue: 242/255, alpha: 1)
                    btn.setImage(UIImage(named: s.name.lowercased() + "-25-white"), for: .normal)
                } else if s.name.lowercased() == "snapchat" {
                    btn.backgroundColor = UIColor(red: 255/255, green: 252/255, blue: 0/255, alpha: 1)
                    btn.setImage(UIImage(named: s.name.lowercased() + "-25-colored"), for: .normal)
                } else if s.name.lowercased() == "instagram" {
                    btn.backgroundColor = UIColor(red: 76/255, green: 76/255, blue: 76/255, alpha: 1)
                    btn.setImage(UIImage(named: s.name.lowercased() + "-25-white"), for: .normal)
                }
                self.vStackView.addArrangedSubview(btn)
            }
        }
        // Do any additional setup after loading the view.
    }

    @objc func openUrlLink(_ sender: UIButton) {
        for s in socials {
            if s.name == sender.restorationIdentifier {
                UIApplication.shared.openURL(URL(string: s.url)!)
                break
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        //viewDidLoad()
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
