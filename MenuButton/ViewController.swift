//
//  ViewController.swift
//  MenuButton
//
//  Created by Evsei, Vladimir on 9/1/16.
//  Copyright © 2016 Evsei, Vladimir. All rights reserved.
//

import UIKit

let leadingExpButtonConstant: CGFloat = 20
let bottomExpButtonConstant: CGFloat = -20
class ViewController: UIViewController, ExpandingButtonDelegate {

    lazy var menuButton: MenuButtons = {
        let button = MenuButtons(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    var expandingButton: ExpandingButton?
    
    var leadingExpButtonConstr:NSLayoutConstraint?
    var bottomExpButtonConstr:NSLayoutConstraint?
    var trailingExpButtonConstr: NSLayoutConstraint?
    var topExpButtonConstr: NSLayoutConstraint?
    var heightExpButtonConstr:NSLayoutConstraint?
    var widthExpButtonConstr:NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.whiteColor()
        menuButton.parentView = self.view
        positionButton()
        positionExpandingButton()
        addItemsToExpandingMenu()
        menuButton.triggerButton.addTarget(self, action: #selector(menuButtonPressed(_:)), forControlEvents: .TouchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func positionButton() {
        view.addSubview(menuButton)
        let views = ["button": menuButton]
        let xConstr = NSLayoutConstraint.constraintsWithVisualFormat("H:[button(50)]-20-|", options: [], metrics: nil, views: views)
        let yConstr = NSLayoutConstraint.constraintsWithVisualFormat("V:[button(50)]-20-|", options: [], metrics: nil, views: views)
        view.addConstraints(xConstr)
        view.addConstraints(yConstr)
    }
    
    private func addItemsToExpandingMenu() {
        guard let expButton = expandingButton else{
            return
        }
        let itemSize = CGSizeMake(40, 40)
        if let image1 = UIImage(named: "chooser-moment-icon-music"){
            let expItem1 = ExpandingItem(size: itemSize, frontImage: image1) {
                print("button-tab ACTION")
            }
            expButton.insertNewItem(expItem1)
        }
        if let image2 = UIImage(named: "chooser-moment-icon-sleep"){
            let expItem2 = ExpandingItem(size: itemSize, frontImage: image2) {
                print("button-tab ACTION")
            }
            expButton.insertNewItem(expItem2)
        }
        if let image3 = UIImage(named: "chooser-moment-icon-thought") {
            let expItem3 = ExpandingItem(size: itemSize, frontImage: image3) {
                print("button-tab ACTION")
            }
             expButton.insertNewItem(expItem3)
        }
    }
    
    private func positionExpandingButton() {
        let image = UIImage(named: "button-tab")
        
//        let expandingButton = ExpandingItem(size: nil, frontImage: image!) {
//            print("button-tab ACTION")
//        }
//        view.addSubview(expandingButton)
//        expandingButton.translatesAutoresizingMaskIntoConstraints = false
//
//        expandingButton.heightAnchor.constraintEqualToAnchor(expandingButton.widthAnchor).active = true
//        let views = ["expandingButton": expandingButton]
//        let xConstr = NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[expandingButton]", options: [], metrics: nil, views: views)
//        let yConstr = NSLayoutConstraint.constraintsWithVisualFormat("V:[expandingButton(50)]-20-|", options: [], metrics: nil, views: views)
//        view.addConstraints(xConstr)
//        view.addConstraints(yConstr)
        
        let expButton = ExpandingButton(size: CGSizeZero, image: image!)
        expButton.delegate = self
        view.addSubview(expButton)
        expButton.translatesAutoresizingMaskIntoConstraints = false
        
        leadingExpButtonConstr = expButton.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: leadingExpButtonConstant)
        bottomExpButtonConstr = expButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: bottomExpButtonConstant)
        heightExpButtonConstr = expButton.heightAnchor.constraintEqualToConstant(38)
        widthExpButtonConstr = expButton.widthAnchor.constraintEqualToConstant(38)
        
        leadingExpButtonConstr?.active = true
        bottomExpButtonConstr?.active = true
        heightExpButtonConstr?.active = true
        widthExpButtonConstr?.active = true
        
        trailingExpButtonConstr = expButton.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor)
        topExpButtonConstr = expButton.topAnchor.constraintEqualToAnchor(view.topAnchor)
        expandingButton = expButton
    }
    
    func menuButtonPressed(sender: UIButton) {
        print ("menuButtonPressed")
        menuButton.layoutButtons()
    }
    
    
    //MARK: - ExpandingButtonDelegate
    func willPresentMenuItems() {
        heightExpButtonConstr?.active = false
        widthExpButtonConstr?.active = false
        leadingExpButtonConstr?.constant = 0
        bottomExpButtonConstr?.constant = 0
        trailingExpButtonConstr?.active = true
        topExpButtonConstr?.active = true
        
    }
    
    func willDismissMenuItems() {
        trailingExpButtonConstr?.active = false
        topExpButtonConstr?.active = false
        heightExpButtonConstr?.active = true
        widthExpButtonConstr?.active = true
        leadingExpButtonConstr?.constant = leadingExpButtonConstant
        bottomExpButtonConstr?.constant = bottomExpButtonConstant
        
    }
}

