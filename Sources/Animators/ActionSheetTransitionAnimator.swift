//
//  ActionSheetTransitionAnimator.swift
//  ModalViewController
//
//  Created by Futao on 16/6/21.
//
//

import Foundation
import UIKit

@objc(LTActionSheetTransitionAnimator)
public class ActionSheetTransitionAnimator: NSObject {
    
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
                modalVc.overlayView.alpha = 0;
                modalVc.rootController.view.frame = CGRectMake((modalVc.view.frame.width-modalVc.presentedViewSize.width)/2, modalVc.view.frame.height, modalVc.presentedViewSize.width, modalVc.presentedViewSize.height)

                UIView.animateWithDuration(0.25, animations: {
                    modalVc.overlayView.alpha = 0.4
                    modalVc.rootController.view.frame = CGRectMake((modalVc.view.frame.width-modalVc.presentedViewSize.width)/2, (modalVc.view.frame.height-modalVc.presentedViewSize.height) - modalVc.presentContentInset, modalVc.presentedViewSize.width, modalVc.presentedViewSize.height)

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
                modalVc.overlayView.alpha = 0
                modalVc.rootController.view.frame = CGRectMake((modalVc.view.frame.width-modalVc.presentedViewSize.width)/2, modalVc.view.frame.height, modalVc.presentedViewSize.width, modalVc.presentedViewSize.height)

                }, completion: { (finished) in
                    transitionContext.completeTransition(finished)
            })
            
        }) { transitionCompleted in
            
        }
    }
    
}