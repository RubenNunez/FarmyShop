//
//  SwipeAnimation.swift
//  FarmyShop
//
//  Created by Ruben Nunez on 15.06.17.
//  Copyright © 2017 Ruben Nuñez. All rights reserved.
//

import Foundation
import CoreData
import UIKit

final class  SwipeAnimation: NSObject, UIViewControllerAnimatedTransitioning {
 
    let duration :  Float = 0.5
    weak var transitionContext : UIViewControllerContextTransitioning?
    var tabBarController : UITabBarController
    var lastIndex : Int
    
    // Last Index is used to determin direction
    init(tabBarController: UITabBarController, lastIndex: Int) {
        self.tabBarController = tabBarController
        self.lastIndex = lastIndex
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        let containerView = transitionContext.containerView
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        
        containerView.addSubview(toViewController!.view)
        
        var viewWidth = toViewController!.view.bounds.width
        
        if tabBarController.selectedIndex < lastIndex {
            viewWidth = -viewWidth
        }
        
        toViewController!.view.transform = CGAffineTransform(translationX: viewWidth, y: 0)
        
        UIView.animate(withDuration: self.transitionDuration(using: (self.transitionContext)), delay: 0.0, usingSpringWithDamping: 1.2, initialSpringVelocity: 2.5, options: .overrideInheritedOptions, animations: {
            toViewController!.view.transform = CGAffineTransform.identity
            fromViewController!.view.transform = CGAffineTransform(translationX: -viewWidth, y: 0)
        }, completion: { _ in
            self.transitionContext?.completeTransition(!(self.transitionContext?.transitionWasCancelled)!)
            fromViewController!.view.transform = CGAffineTransform.identity
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(duration)
    }
}
