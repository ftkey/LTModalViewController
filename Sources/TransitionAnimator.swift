//
//  TransitionAnimator.swift
//  ModalViewController
//
//  Created by Futao on 16/6/16.
//  Copyright © 2016年 Futao.me. All rights reserved.
//

import UIKit
import Foundation

@objc(LTTransitionAnimator)
public class TransitionAnimator: NSObject {
    
    private var transitionDuration : NSTimeInterval = 0.25
    private var animateTransitionHandler : ((transitionContext: UIViewControllerContextTransitioning) ->Void)?
    private var completionHandler : ((Bool) -> Void)?

    public init(duration : NSTimeInterval = 0.25 , animations:((transitionContext: UIViewControllerContextTransitioning) -> Void)? = nil, completion:((Bool) -> Void)? = nil){
        super.init()
        transitionDuration = duration
        animateTransitionHandler = animations
        completionHandler = completion
    }
}
extension TransitionAnimator: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return transitionDuration
    }
    
    public func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        if let animateTransitionHandler = animateTransitionHandler {
            animateTransitionHandler(transitionContext:transitionContext)
        }
        
    }
    
    public func animationEnded(transitionCompleted: Bool) {
        if let completionHandler = completionHandler {
            completionHandler(transitionCompleted)
        }
    }
}
extension TransitionAnimator:UIViewControllerTransitioningDelegate {
    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
