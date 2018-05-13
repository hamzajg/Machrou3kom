//
//  UIButtonAnimationExt.swift
//  Machrou3kom
//
//  Created by Hamza JGUERIM on 2018-05-13.
//  Copyright © 2018 Hamza JGUERIM. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.95
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 2
        pulse.initialVelocity = 0.5
        pulse.damping = 1.0
        
        layer.add(pulse, forKey: nil)
    }
}
