//
//  ViewController.swift
//  Example
//
//  Created by Futao on 16/6/16.
//  Copyright © 2016年 Ftkey. All rights reserved.
//

import UIKit

import LTModalViewController

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func onAlert(sender: AnyObject) {
        let rootVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ModalController")
        self.presentViewController(ModalViewController(rootController:rootVc ,contentSize:CGSizeMake(320, 200),radius:8, style:.Alert), animated: true, completion: nil)
        
    }
    
    @IBAction func onAlertNav(sender: AnyObject) {
        let rootVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ModalController")
        self.presentViewController(ModalViewController(rootController:UINavigationController(rootViewController:rootVc ) ,contentSize:CGSizeMake(320, 200),radius:8, style:.Alert), animated: true, completion: nil)
        
    }
    @IBAction func onActionSheet(sender: AnyObject) {
        let rootVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ModalController")
        self.presentViewController(ModalViewController(rootController:rootVc ,contentSize:CGSizeMake(320, 200), style:.ActionSheet), animated: true, completion: nil)
        
    }
    
    @IBAction func onActionSheetNav(sender: AnyObject) {
        let rootVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ModalController")
        self.presentViewController(ModalViewController(rootController:UINavigationController(rootViewController:rootVc ) ,contentSize:CGSizeMake(320, 200), style:.ActionSheet), animated: true, completion: nil)
        
    }
    @IBAction func onCustom(sender: AnyObject) {
        let rootVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ModalController")
        let presentAnimator:TransitionAnimator = TransitionAnimator(duration: 0.5, animations: { transitionContext in
            
            guard let contextController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
                return
            }
            guard let modalVc = contextController as? ModalViewController else {
                return
            }
            if let containerView = transitionContext.containerView() {
                containerView.addSubview(modalVc.view)
                modalVc.rootController.view.transform = CGAffineTransformMakeScale(3, 3);
                UIView.animateWithDuration(0.5, animations: {
                    modalVc.overlayView.alpha = 0.4
                    modalVc.rootController.view.transform = CGAffineTransformIdentity
                    }, completion: { (finished) in
                        transitionContext.completeTransition(finished)
                })
            }
            
            }, completion: nil)
        let dismissAnimator:TransitionAnimator = TransitionAnimator(duration: 0.5, animations: { transitionContext in
            
            guard let contextController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) else {
                return
            }
            guard let modalVc = contextController as? ModalViewController else {
                return
            }
            if let _ = transitionContext.containerView() {
                UIView.animateWithDuration(0.5, animations: {
                    modalVc.overlayView.alpha = 0
                    modalVc.rootController.view.transform = CGAffineTransformMakeScale(3, 3);
                    }, completion: { (finished) in
                        transitionContext.completeTransition(finished)
                })
            }
            
            }, completion: nil)
        self.presentViewController(ModalViewController(rootController:rootVc ,contentSize:CGSizeMake(320, 200), presentAnimator:presentAnimator,dismissAnimator:dismissAnimator), animated: true, completion: nil)
        
    }
    
    @IBAction func onCustomNav(sender: AnyObject) {
        let rootVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ModalController")
        let presentAnimator:TransitionAnimator = TransitionAnimator(duration: 0.5, animations: { transitionContext in
            
            guard let contextController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) else {
                return
            }
            guard let modalVc = contextController as? ModalViewController else {
                return
            }
            if let containerView = transitionContext.containerView() {
                containerView.addSubview(modalVc.view)
                modalVc.rootController.view.transform = CGAffineTransformMakeRotation(-3.14);
                UIView.animateWithDuration(0.5, animations: {
                    modalVc.overlayView.alpha = 0.4
                    modalVc.rootController.view.transform = CGAffineTransformIdentity
                    }, completion: { (finished) in
                        transitionContext.completeTransition(finished)
                })
            }
            
            }, completion: nil)
        let dismissAnimator:TransitionAnimator = TransitionAnimator(duration: 0.5, animations: { transitionContext in
            
            guard let contextController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) else {
                return
            }
            guard let modalVc = contextController as? ModalViewController else {
                return
            }
            if let _ = transitionContext.containerView() {
                UIView.animateWithDuration(0.5, animations: {
                    modalVc.overlayView.alpha = 0
                    modalVc.rootController.view.transform = CGAffineTransformMakeRotation(3.14);
                    }, completion: { (finished) in
                        transitionContext.completeTransition(finished)
                })
            }
            
            }, completion: nil)
        self.presentViewController(ModalViewController(rootController:UINavigationController(rootViewController:rootVc ) ,contentSize:CGSizeMake(320, 200), presentAnimator:presentAnimator,dismissAnimator:dismissAnimator), animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

