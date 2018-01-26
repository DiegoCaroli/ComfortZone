//
//  PopupDismissAnimationController.swift
//  ComfortZone
//
//  Created by Diego Caroli on 04/01/2018.
//  Copyright © 2018 Diego Caroli. All rights reserved.
//

import UIKit

class PopupDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.4
  }

  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    if let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) {
      let time = transitionDuration(using: transitionContext)
      
      UIView.animate(withDuration: time, animations: {
        fromView.alpha = 0
        fromView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
      }, completion: { finished in
        fromView.removeFromSuperview()
        transitionContext.completeTransition(finished)
      })
    }
  }
}
