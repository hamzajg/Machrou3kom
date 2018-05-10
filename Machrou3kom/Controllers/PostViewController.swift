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
    @IBOutlet weak var postLikesCountLabel: UILabel!
    @IBOutlet weak var sliderPageControl: UIPageControl!
    @IBOutlet weak var sliderScrollView: UIScrollView!
    var post:Post! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        if post != nil {
            self.title = post.title
            postTitleLabel.text = post.title
            postTypeLabel.text = post.typePost
            postLocationLabel.text = post.adresse
            postPhoneNumberLabel.text = post.numTel
            postPostedAtLabel.text = String(post.createdAt.description[..<post.createdAt.description.index(of: "+")!])
            postLikesCountLabel.text = String(post.getLikesCount())
            
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
        }
        // Do any additional setup after loading the view.
    }

    //ScrollView Method
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        sliderPageControl.numberOfPages = Int(pageNumber)
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
