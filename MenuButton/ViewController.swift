//
//  ViewController.swift
//  MenuButton
//
//  Created by Evsei, Vladimir on 9/1/16.
//  Copyright © 2016 Evsei, Vladimir. All rights reserved.
//

import UIKit

let trailingExpButtonConstant: CGFloat = -20
let bottomExpButtonConstant: CGFloat = -20
class ViewController: UIViewController, ExpandingButtonDelegate {

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
        positionExpandingButton()
        addItemsToExpandingMenu()
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
        
        let expButton = ExpandingButton(size: CGSizeZero, image: image!)
        expButton.delegate = self
        view.addSubview(expButton)
        expButton.translatesAutoresizingMaskIntoConstraints = false
        
        trailingExpButtonConstr = expButton.trailingAnchor.constraintEqualToAnchor(view.trailingAnchor, constant: trailingExpButtonConstant)
        bottomExpButtonConstr = expButton.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: bottomExpButtonConstant)
        heightExpButtonConstr = expButton.heightAnchor.constraintEqualToConstant(38)
        widthExpButtonConstr = expButton.widthAnchor.constraintEqualToConstant(38)
        
        trailingExpButtonConstr?.active = true
        bottomExpButtonConstr?.active = true
        heightExpButtonConstr?.active = true
        widthExpButtonConstr?.active = true
        
        leadingExpButtonConstr = expButton.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor)
        topExpButtonConstr = expButton.topAnchor.constraintEqualToAnchor(view.topAnchor)
        expandingButton = expButton
    }    
    
    //MARK: - ExpandingButtonDelegate
    func willPresentMenuItems() {
        heightExpButtonConstr?.active = false
        widthExpButtonConstr?.active = false
        trailingExpButtonConstr?.constant = 0
        
        bottomExpButtonConstr?.constant = 0
        leadingExpButtonConstr?.active = true
        topExpButtonConstr?.active = true
        
    }
    
    func willDismissMenuItems() {
        leadingExpButtonConstr?.active = false
        topExpButtonConstr?.active = false
        heightExpButtonConstr?.active = true
        widthExpButtonConstr?.active = true
        trailingExpButtonConstr?.constant = trailingExpButtonConstant
        bottomExpButtonConstr?.constant = bottomExpButtonConstant
    }
}

