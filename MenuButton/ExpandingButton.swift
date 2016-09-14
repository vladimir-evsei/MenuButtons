//
//  ExpandingButton.swift
//  MenuButton
//
//  Created by Evsei, Vladimir on 9/2/16.
//  Copyright © 2016 Evsei, Vladimir. All rights reserved.
//

import UIKit


protocol ExpandingButtonDelegate {
    func willPresentMenuItems()
    func willDismissMenuItems()
}

class ExpandingButton: UIView, UIGestureRecognizerDelegate {
    
    private var defaultCenter: CGPoint = CGPointZero
    private let backViewSize = UIScreen.mainScreen().bounds.size
    private var backView = UIView()
    private let centerButton = UIButton()
    private var isExpanded = false
    
    private var leadingButton: NSLayoutConstraint?
    private var trailingButton: NSLayoutConstraint?
    private var bottomButton: NSLayoutConstraint?
    private var topButton: NSLayoutConstraint?
    private var menuItemMargin: CGFloat = 16.0
    
    lazy var animator: UIDynamicAnimator = {
        return UIDynamicAnimator(referenceView: self)
    }()
    
    
    var backgroundViewColor: UIColor = UIColor.grayColor() {
        didSet{
            backView.backgroundColor = backgroundViewColor
        }
    }
    var backgroundViewAlpha: CGFloat = 0.5
    var centerButtonImage: UIImage {
        didSet{
            centerButton.setBackgroundImage(centerButtonImage, forState: .Normal)
        }
    }
    var delegate: ExpandingButtonDelegate?
    private var itemsArr = [ExpandingItem]()
    
    //MARK: - Inits
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    init(size: CGSize?, image: UIImage) {
        
        var centerFrame: CGRect
        if let centerSize = size {
            centerFrame = CGRect(origin: CGPointZero, size: centerSize)
        } else {
            centerFrame = CGRect(origin: CGPointZero, size: CGSize(width: image.size.width, height: image.size.height))
        }
        centerButtonImage = image
        
        super.init(frame: centerFrame)
        
        backView.backgroundColor = UIColor.grayColor()
        centerButton.frame = centerFrame
        centerButton.setBackgroundImage(image, forState: .Normal)
        centerButton.addTarget(self, action: #selector(centerButtonTapped(_:)), forControlEvents: .TouchUpInside)
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(centerButton)
        
        centerButton.heightAnchor.constraintEqualToConstant(image.size.height).active = true
        centerButton.widthAnchor.constraintEqualToConstant(image.size.height).active = true
        
        topButton = centerButton.topAnchor.constraintEqualToAnchor(topAnchor)
        topButton?.active = true

        leadingButton = centerButton.leadingAnchor.constraintEqualToAnchor(leadingAnchor)
        leadingButton?.active = true

        backView.frame = CGRect(origin: CGPointMake(0, 0), size: backViewSize)
        backView.alpha = 0.0
        backView.userInteractionEnabled = true;
        let tapGesture = UIGestureRecognizer()
        tapGesture.delegate = self
        backView.addGestureRecognizer(tapGesture)
    }
    
    //MARK: - Methods
    func insertNewItem(item: ExpandingItem) {
        itemsArr.append(item)
    }
    
    private func expandMenuItems() {
        defaultCenter = center
        
        topButton?.constant = center.y - centerButton.frame.height / 2
        leadingButton?.constant = center.x - centerButton.frame.width / 2
        
        delegate?.willPresentMenuItems()
        insertSubview(backView, belowSubview: centerButton)
        UIView.animateWithDuration(0.4, animations: {
            self.backView.alpha = self.backgroundViewAlpha
        })
        var lastItemY: CGFloat = defaultCenter.y
        
        for (_, item) in itemsArr.enumerate() {
            print(item.frame)
            
            print(item.center)
            
            item.center = defaultCenter
            insertSubview(item, belowSubview: centerButton)
            
            let newYCoordinate = lastItemY - menuItemMargin - item.frame.size.height
            let newItemPoint = CGPointMake(self.defaultCenter.x, newYCoordinate)
            let snap = UISnapBehavior(item: item, snapToPoint: newItemPoint)
            animator.addBehavior(snap)
            
            lastItemY = newYCoordinate
        }
        isExpanded = true
    }
    
    private func hideMenuItems() {
        UIView.animateWithDuration(1, animations: {
            self.backView.alpha = 0
            }) { (_) in
                self.backView.removeFromSuperview()
                self.topButton?.constant = 0
                self.leadingButton?.constant = 0
                self.delegate?.willDismissMenuItems()
        }
        isExpanded = false
    }
    
    //MARK: - Actions
    @objc private func centerButtonTapped(sender: UIButton) {
        
        if !isExpanded {
            expandMenuItems()
        } else {
            hideMenuItems()
        }
    }
    
    // MARK: - UIGestureRecognizer Delegate
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        hideMenuItems()
    }
    
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}