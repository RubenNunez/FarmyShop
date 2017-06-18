//
//  FadeAnimation.swift
//  FarmyShop
//
//  Created by Ruben Nunez on 14.06.17.
//  Copyright © 2017 Ruben Nuñez. All rights reserved.
//

import Foundation
import UIKit
import CoreData

final class FadeAnimation: NSObject, UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromView: UIView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView: UIView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        transitionContext.containerView.addSubview(fromView)
        transitionContext.containerView.addSubview(toView)
        
        UIView.transition(from: fromView, to: toView, duration: transitionDuration(using: transitionContext), options: .transitionCrossDissolve) { finished in
            transitionContext.completeTransition(true)
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
}
