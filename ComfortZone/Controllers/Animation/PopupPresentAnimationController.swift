//
//  PopupPresentAnimationController.swift
//  ComfortZone
//
//  Created by Diego Caroli on 04/01/2018.
//  Copyright © 2018 Diego Caroli. All rights reserved.
//

import UIKit

class PopupPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.3
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    if let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
      let containerView = transitionContext.containerView
      let time = transitionDuration(using: transitionContext)
      
      toView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
      toView.alpha = 0.0
      toView.clipsToBounds = true
      containerView.addSubview(toView)
      
      UIView.animate(withDuration: time, animations: {
        toView.alpha = 1.0
        toView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
      }, completion: { finished in
        transitionContext.completeTransition(finished)
      })
    }
  }
}
