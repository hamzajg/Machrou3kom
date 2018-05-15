//
//  CardView.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-05-14.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import UIKit

@IBDesignable class CardView: UIView {
    
    
    var cornerRadius: CGFloat = 0
    var shadowOffsetWidth: CGFloat = 0
    var shadowOffsetHeight: CGFloat = 1
    var shadowColor: CGColor = UIColor.black.cgColor
    var shadowOpacity: CGFloat = 0.2
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = Float(shadowOpacity)
        layer.cornerRadius = cornerRadius
    }
}
