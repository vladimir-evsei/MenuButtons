//
//  MenuButtons.swift
//  MenuButton
//
//  Created by Evsei, Vladimir on 9/1/16.
//  Copyright © 2016 Evsei, Vladimir. All rights reserved.
//

import UIKit

enum MNButtonState: Int {
    case Hidden = 0
    case Shown
}

class MenuButtons: UIView {
    
    var buttonsArray = [UIButton]()
    var state: MNButtonState = .Hidden
    let buttonSize: CGSize = CGSizeMake(55, 55)
    let verticalSpacing: CGFloat = 15.0
    var parentView: UIView?
    
    let triggerButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.blueColor()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
    override init(frame: CGRect) {
        super.init(frame: frame)
        triggerButton.layer.cornerRadius = frame.size.height / 2
        setupTriggerButton()
        addButtons()
        //        layoutButtons()
    }
    
    private func setupTriggerButton() {
        addSubview(triggerButton)
        let views = ["button": triggerButton]
        let xConstr = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[button]-0-|", options: [], metrics: nil, views: views)
        let yConstr = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[button]-0-|", options: [], metrics: nil, views: views)
        addConstraints(xConstr)
        addConstraints(yConstr)
    }
    
    func addButtons() {
        
        for _ in 1..<4 {
            let r: CGFloat = CGFloat(arc4random_uniform(256))/256
            let g: CGFloat = CGFloat(arc4random_uniform(256))/256
            let b: CGFloat = CGFloat(arc4random_uniform(256))/256
            let color = UIColor(red: r, green: g, blue: b, alpha: 1.0)
            let button = UIButton()
            button.backgroundColor = color
            //            button.translatesAutoresizingMaskIntoConstraints = false
            buttonsArray.append(button)
            button.frame = triggerButton.frame
        }
    }
    
    func layoutButtons() {
        var prevButton: UIButton? = nil
        for button in buttonsArray {
            var buttonY: CGFloat = 0
            if let prevButton = prevButton {
                buttonY = prevButton.frame.minY - verticalSpacing - buttonSize.height
            } else {
                buttonY = triggerButton.frame.minY - verticalSpacing - buttonSize.height
            }
            print(button.frame)
            triggerButton.addSubview(button)
            triggerButton.bringSubviewToFront(button)
            button.addTarget(self, action: #selector(menuButtonPressed), forControlEvents: .TouchUpInside)
            prevButton = button
            
            UIView.animateWithDuration(2, animations: { 
                button.frame = CGRect(origin: CGPoint(x: self.triggerButton.frame.minX, y: buttonY), size: self.buttonSize)
            })
        }
    }
    func menuButtonPressed() {
        print("---PRESSED---")
    }
    
    //    private func getButtonPoxXForState(state: MNButtonState) -> CGFloat {
    //        return state == .Hidden ? ≈
    //    }
    
}
