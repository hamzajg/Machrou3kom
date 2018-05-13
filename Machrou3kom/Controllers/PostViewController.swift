//
//  PostViewController.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-05-05.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import UIKit

class PostViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postTypeLabel: UILabel!
    @IBOutlet weak var postLocationLabel: UILabel!
    @IBOutlet weak var postPhoneNumberLabel: UILabel!
    @IBOutlet weak var postDescLabel: UILabel!
    @IBOutlet weak var postPostedAtLabel: UILabel!
    @IBOutlet weak var sliderPageControl: UIPageControl!
    @IBOutlet weak var sliderScrollView: UIScrollView!
    var post:Post! = nil
    @IBOutlet weak var likeBtn: UIButton!
    @IBAction func callBtnAction(_ sender: UIButton) {
        guard let number = URL(string: "tel://" + String(post.numTel)) else { return }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(number)
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(number)
        }
    }
    @IBAction func likeBtnAction(_ sender: UIButton) {
        
        if(!ViewController.isGuest) {
            let defaults = UserDefaults.standard
            
            // Receive
            if let profile_sub = defaults.string(forKey: "profile_sub")
            {
                if profile_sub != post.itemKey {
                    let appServices = AppServices()
                    appServices.LikePost(sub1: post.itemKey, sub2: profile_sub) {(result) in
                        let b = (result)
                        if b {appServices.AddNewNotification(sub1: self.post.itemKey, sub2: profile_sub)
                            self.likeBtn.setImage(UIImage(named: "heart-outline-filled-25"), for: .normal)
                            let likeCount = self.likeBtn.titleLabel?.text?.count == 0 ? 0 : Int((self.likeBtn.titleLabel?.text)!)
                            self.likeBtn.setTitle(String(likeCount! + 1), for: .normal)
                            sender.pulsate()
                        }
                    }
                }
            }
        } else {
            let alert = UIAlertController(title: self.title, message: "يجب عليك تسجيل الدخول لاستخدام هذه الخاصية", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "حسنا", style: .default, handler: {(action:UIAlertAction!) in
                self.performSegue(withIdentifier: "goSignInPage", sender: self)
            }))
            alert.addAction(UIAlertAction(title: "لا أريد", style: .cancel, handler: nil))
            
            self.present(alert, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        if post != nil {
            self.title = post.title
            postTitleLabel.text = post.title
            postTypeLabel.text = post.typePost
            postLocationLabel.text = post.adresse
            postDescLabel.text = post.description
            postPhoneNumberLabel.text = "\(post.numTel)"
            postPostedAtLabel.text = String(post.createdAt.description[..<post.createdAt.description.index(of: "+")!])
            postPostedAtLabel.text!.removeLast(4)
            likeBtn.setTitle(post.getLikesCount() == 0 ? "" : String(post.getLikesCount()), for: .normal)
            if post.getLikesCount() > 0 {
                likeBtn.setImage(UIImage(named: "heart-outline-filled-25"), for: .normal)
            }
            self.sliderPageControl.numberOfPages = self.post.photos.count
            for i in 0..<self.post.photos.count {
                let p = self.post.photos[i]
                if let url = URL(string: (p.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil))) {
                    DispatchQueue.global().async {
                        let data = try? Data(contentsOf: url)
                        DispatchQueue.main.async {
                            let imageView = UIImageView(frame: CGRect(x:  self.sliderScrollView.frame.size.width * CGFloat(i), y: 0, width:  self.sliderScrollView.frame.size.width, height:  self.sliderScrollView.frame.size.height))
                            if data != nil {
                                imageView.image = UIImage(data: data!)
                            }
                            self.sliderScrollView.addSubview(imageView)
                        }
                    }
                }
                
                self.sliderScrollView.contentSize = CGSize(width: (self.sliderScrollView.frame.size.width * CGFloat(self.post.photos.count)), height: self.sliderScrollView.frame.size.height)
                self.sliderScrollView.delegate = self

            }
            
            let appServices = AppServices()
            appServices.GetOnePostByUserAsync(sub: post.itemKey) {(post) in
                let p = (post)
                let c = p?.getLikesCount()
                self.likeBtn.setTitle(c! == 0 ? "" : "\(c!)", for: .normal)
            }
        }
        // Do any additional setup after loading the view.
    }

    //ScrollView Method
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        sliderPageControl.currentPage = Int(pageNumber)
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
