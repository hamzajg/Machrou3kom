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
            for s in self.socials {
                let btn = UIButton(type: UIButtonType.system)
                btn.frame = CGRect(x: 0, y: 0, width: 150, height: 50)
                btn.restorationIdentifier = s.name
                btn.setImage(UIImage(named: s.name.lowercased() + "-25"), for: .normal)
                btn.setTitle("Mshro3com_app", for: .normal)
                btn.addTarget(self, action: #selector(self.openUrlLink(_:)), for: .touchUpInside)
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
