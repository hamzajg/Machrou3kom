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
        let appServices = AppServices()
        appServices.GetAllSocialsAsync() {(socials) in
            self.socials = (socials)
            for s in self.socials {
                let btn = UIButton(type: UIButtonType.custom)
                btn.frame = CGRect(x: 0, y: 10, width: 150, height: 27)
                btn.restorationIdentifier = s.name
                btn.setTitle(String(s.name.prefix(1)).capitalized + String(s.name.dropFirst()), for: .normal)
                btn.semanticContentAttribute = .forceRightToLeft
                btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 150, bottom: 0, right: 0)
                btn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
                btn.layer.cornerRadius = 8.0;
                btn.layer.masksToBounds = false;
                //btn.layer.borderWidth = 1.0;
                btn.contentHorizontalAlignment = .right;
                btn.layer.shadowColor = UIColor.gray.cgColor;
                btn.layer.shadowOpacity = 0.8;
                btn.layer.shadowRadius = 5;
                btn.layer.shadowOffset = CGSize(width: 3.0, height: 3.0);
                btn.addTarget(self, action: #selector(self.openUrlLink(_:)), for: .touchUpInside)
                btn.setTitleColor(UIColor.gray, for: .normal)
                btn.layer.cornerRadius = 5
                btn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 5)
                btn.backgroundColor = UIColor.white
                btn.setImage(UIImage(named: s.name.lowercased()), for: .normal)
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
