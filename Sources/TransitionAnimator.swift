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
open class TransitionAnimator: NSObject {
    
    fileprivate var transitionDuration : TimeInterval = 0.25
    fileprivate var animateTransitionHandler : ((_ transitionContext: UIViewControllerContextTransitioning) ->Void)?
    fileprivate var completionHandler : ((Bool) -> Void)?

    public init(duration : TimeInterval = 0.25 , animations:((_ transitionContext: UIViewControllerContextTransitioning) -> Void)? = nil, completion:((Bool) -> Void)? = nil){
        super.init()
        transitionDuration = duration
        animateTransitionHandler = animations
        completionHandler = completion
    }
}
extension TransitionAnimator: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if let animateTransitionHandler = animateTransitionHandler {
            animateTransitionHandler(transitionContext)
        }
        
    }
    
    public func animationEnded(_ transitionCompleted: Bool) {
        if let completionHandler = completionHandler {
            completionHandler(transitionCompleted)
        }
    }
}
extension TransitionAnimator:UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
