//
//  CircleImage.swift
//  smack
//
//  Created by McL on 9/3/18.
//  Copyright © 2018 McL. All rights reserved.
//

import UIKit
@IBDesignable

class CircleImage: UIImageView {
    override func awakeFromNib() {
        setupView()
    }
    
    func setupView ()
    {
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        
        setupView()
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
