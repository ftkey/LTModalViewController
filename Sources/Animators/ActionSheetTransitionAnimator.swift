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
open class ActionSheetTransitionAnimator: NSObject {
    
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
            modalVc.overlayView.alpha = 0;
            modalVc.rootController.view.frame = CGRect(x: (modalVc.view.frame.width-modalVc.presentedViewSize.width)/2, y: modalVc.view.frame.height, width: modalVc.presentedViewSize.width, height: modalVc.presentedViewSize.height)
            
            UIView.animate(withDuration: 0.25, animations: {
                modalVc.overlayView.alpha = 0.4
                modalVc.rootController.view.frame = CGRect(x: (modalVc.view.frame.width-modalVc.presentedViewSize.width)/2, y: (modalVc.view.frame.height-modalVc.presentedViewSize.height) - modalVc.presentContentInset, width: modalVc.presentedViewSize.width, height: modalVc.presentedViewSize.height)
                
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
                modalVc.overlayView.alpha = 0
                modalVc.rootController.view.frame = CGRect(x: (modalVc.view.frame.width-modalVc.presentedViewSize.width)/2, y: modalVc.view.frame.height, width: modalVc.presentedViewSize.width, height: modalVc.presentedViewSize.height)
                
            }, completion: { (finished) in
                transitionContext.completeTransition(finished)
            })
            
        }) { transitionCompleted in
            
        }
    }
    
}
