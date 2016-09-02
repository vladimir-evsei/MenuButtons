//
//  ExpandingItem.swift
//  MenuButton
//
//  Created by Evsei, Vladimir on 9/2/16.
//  Copyright © 2016 Evsei, Vladimir. All rights reserved.
//

import UIKit

class ExpandingItem: UIView {
    
    private var frontImageView: UIImageView
    private var tappedAction: (() -> ())?
    
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented") }
    
    init(size: CGSize?, frontImage: UIImage, buttonAction: (() -> ())?) {
        
        frontImageView = UIImageView(image: frontImage)
        let buttonFrame: CGRect
        
        if let buttonSize = size where size != CGSizeZero{
            buttonFrame = CGRect(origin: CGPointZero, size: buttonSize)
        } else {
            buttonFrame = CGRect(origin: CGPointZero, size: CGSizeMake(frontImage.size.width, frontImage.size.height))
        }
        tappedAction = buttonAction
        
        super.init(frame: buttonFrame)
        
        let button = UIButton()
        button.setBackgroundImage(frontImage, forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped(_:)), forControlEvents: .TouchUpInside)
        addSubview(button)
        button.leadingAnchor.constraintEqualToAnchor(leadingAnchor).active = true
        button.trailingAnchor.constraintEqualToAnchor(trailingAnchor).active = true
        button.bottomAnchor.constraintEqualToAnchor(bottomAnchor).active = true
        button.topAnchor.constraintEqualToAnchor(topAnchor).active = true
        
    }
    
    func buttonTapped(sender: UIButton) {
        print("buttonTapped")
        tappedAction?()
    }
}
