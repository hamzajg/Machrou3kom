//
//  CircleImageView.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-05-31.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import UIKit

class CircleImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override func layoutSubviews() {
        layer.cornerRadius = frame.size.width / 2
        clipsToBounds = true
    }
    
}
