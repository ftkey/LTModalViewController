//
//  AlertTransitionAnimator.swift
//  ModalViewController
//
//  Created by Futao on 16/6/21.
//
//

import Foundation
import UIKit

@objc(LTAlertTransitionAnimator)
public class AlertTransitionAnimator: NSObject {
    
    public static var presentAnimator:TransitionAnimator  {
        return TransitionAnimator(duration: 0.25, animations: { transitionContext in
            
            guard let contextController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
                return
            }
            guard let modalVc = contextController as? ModalViewController else {
                return
            }
            
            if let containerView = transitionContext.containerView() {
                containerView.addSubview(modalVc.view)
                modalVc.rootController.view.frame = CGRectMake((modalVc.view.frame.width-modalVc.presentedViewSize.width)/2, (modalVc.view.frame.height-modalVc.presentedViewSize.height)/2 + modalVc.presentContentInset, modalVc.presentedViewSize.width, modalVc.presentedViewSize.height)
                modalVc.overlayView.alpha = 0;
                modalVc.rootController.view.alpha = 0;
                modalVc.rootController.view.transform = CGAffineTransformMakeScale(1.3, 1.3);

                UIView.animateWithDuration(0.25, animations: {
                    modalVc.overlayView.alpha = 0.4
                    modalVc.rootController.view.alpha = 1
                    modalVc.rootController.view.transform = CGAffineTransformIdentity
                    }, completion: { (finished) in
                        transitionContext.completeTransition(finished)
                })
            }
            
        }) { transitionCompleted in
            
        }
    }
    
    public static var dismissAnimator:TransitionAnimator  {
        
        return TransitionAnimator(duration: 0.25, animations: { transitionContext in
            guard let contextController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) else {
                return
            }
            guard let modalVc = contextController as? ModalViewController else {
                return
            }
            UIView.animateWithDuration(0.25, animations: {
                modalVc.view.alpha = 0;
                modalVc.overlayView.alpha = 0;
                modalVc.rootController.view.transform = CGAffineTransformMakeScale(1.3, 1.3);

                }, completion: { (finished) in
                    modalVc.rootController.view.transform = CGAffineTransformIdentity;
                    transitionContext.completeTransition(finished)
            })
            
        }) { transitionCompleted in
            
        }
    }
    
}