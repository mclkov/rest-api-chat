//
//  RoundedButton.swift
//  smack
//
//  Created by McL on 8/23/18.
//  Copyright © 2018 McL. All rights reserved.
//

import UIKit

@IBDesignable
class RoundedButton: UIButton {

    @IBInspectable var cornerRadius: CGFloat = 5.0
    {
        didSet
        {
            self.layer.cornerRadius = cornerRadius
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    override func prepareForInterfaceBuilder() {
        self.setupView()
    }
    
    func setupView()
    {
        self.layer.cornerRadius = cornerRadius
    }
}
