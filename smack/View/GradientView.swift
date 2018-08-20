//
//  GradientView.swift
//  smack
//
//  Created by McL on 8/20/18.
//  Copyright © 2018 McL. All rights reserved.
//

import UIKit

@IBDesignable
class GradientView: UIView {
    
    @IBInspectable var topColor: UIColor = UIColor(red: 74.0/255.0, green: 77.0/255.0, blue: 216.0/255.0, alpha: 1)
    {
        didSet
        {
            self.setNeedsLayout()
        }
    }

    @IBInspectable var bottomColor: UIColor = UIColor(red: 44.0/255.0, green: 212.0/255.0, blue: 216.0/255.0, alpha: 1)
    {
        didSet
        {
            self.setNeedsLayout()
        }
    }

    override func layoutSubviews()
    {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
