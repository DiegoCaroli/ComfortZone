//
//  PhotoPresentAnimationController.swift
//  ComfortZone
//
//  Created by Diego Caroli on 04/01/2018.
//  Copyright © 2018 Diego Caroli. All rights reserved.
//

import UIKit

class PhotoPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
  var originalFrame = CGRect.zero
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return 0.5
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    if let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
      let containerView = transitionContext.containerView
      let time = transitionDuration(using: transitionContext)
      
      let finalFrame = toView.frame
      let xScaleFactor = originalFrame.width / finalFrame.width
      let yScaleFactor = originalFrame.height / finalFrame.height
      
      toView.transform = CGAffineTransform(scaleX: xScaleFactor, y: yScaleFactor)
      toView.center = CGPoint(x: originalFrame.midX, y: originalFrame.midY)
      toView.clipsToBounds = true
      containerView.addSubview(toView)
      
      UIView.animate(withDuration: time, animations: {
        toView.transform = CGAffineTransform.identity
        toView.center = CGPoint(x: finalFrame.midX, y: finalFrame.midY)
      }, completion: { finished in
        transitionContext.completeTransition(finished)
      })
    }
  }
}
