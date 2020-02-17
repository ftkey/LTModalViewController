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
open class AlertTransitionAnimator: NSObject {
    
    @objc open static var presentAnimator:TransitionAnimator  {
        return TransitionAnimator(duration: 0.25, animations: { transitionContext in
            
            guard let contextController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
                return
            }
            guard let modalVc = contextController as? ModalViewController else {
                return
            }
            let containerView = transitionContext.containerView
            containerView.addSubview(modalVc.view)
            modalVc.rootController.view.frame = CGRect(x: (modalVc.view.frame.width-modalVc.presentedViewSize.width)/2, y: (modalVc.view.frame.height-modalVc.presentedViewSize.height)/2 + modalVc.presentContentInset, width: modalVc.presentedViewSize.width, height: modalVc.presentedViewSize.height)
            modalVc.overlayView.alpha = 0;
            modalVc.rootController.view.alpha = 0;
            modalVc.rootController.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3);
            
            UIView.animate(withDuration: 0.25, animations: {
                modalVc.overlayView.alpha = 0.4
                modalVc.rootController.view.alpha = 1
                modalVc.rootController.view.transform = CGAffineTransform.identity
            }, completion: { (finished) in
                transitionContext.completeTransition(finished)
            })
            
        }) { transitionCompleted in
            
        }
    }
    
    @objc open static var dismissAnimator:TransitionAnimator  {
        
        return TransitionAnimator(duration: 0.25, animations: { transitionContext in
            guard let contextController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
                return
            }
            guard let modalVc = contextController as? ModalViewController else {
                return
            }
            UIView.animate(withDuration: 0.25, animations: {
                modalVc.view.alpha = 0;
                modalVc.overlayView.alpha = 0;
                modalVc.rootController.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3);
                
            }, completion: { (finished) in
                modalVc.rootController.view.transform = CGAffineTransform.identity;
                transitionContext.completeTransition(finished)
            })
            
        }) { transitionCompleted in
            
        }
    }
    
}
