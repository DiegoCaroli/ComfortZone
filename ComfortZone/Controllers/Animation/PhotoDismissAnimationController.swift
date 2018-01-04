//
//  PhotoDismissAnimationController.swift
//  ComfortZone
//
//  Created by Diego Caroli on 04/01/2018.
//  Copyright © 2018 Diego Caroli. All rights reserved.
//

import UIKit

class PhotoDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.5
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    if let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) {
      let time = transitionDuration(using: transitionContext)
      
      UIView.animate(withDuration: time, animations: {
        fromView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
      }, completion: { finished in
        fromView.removeFromSuperview()
        transitionContext.completeTransition(finished)
      })
    }
  }
}

