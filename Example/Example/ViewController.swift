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
    
    @IBAction func onAlert(_ sender: AnyObject) {
        let rootVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModalController")
        self.present(ModalViewController(rootController:rootVc ,contentSize:CGSize(width: 320, height: 200),radius:8, style:.alert), animated: true, completion: nil)
        
    }
    
    @IBAction func onAlertNav(_ sender: AnyObject) {
        let rootVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModalController")
        self.present(ModalViewController(rootController:UINavigationController(rootViewController:rootVc ) ,contentSize:CGSize(width: 320, height: 200),radius:8, style:.alert), animated: true, completion: nil)
        
    }
    @IBAction func onActionSheet(_ sender: AnyObject) {
        let rootVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModalController")
        self.present(ModalViewController(rootController:rootVc ,contentSize:CGSize(width: 320, height: 200), style:.actionSheet), animated: true, completion: nil)
        
    }
    
    @IBAction func onActionSheetNav(_ sender: AnyObject) {
        let rootVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModalController")
        self.present(ModalViewController(rootController:UINavigationController(rootViewController:rootVc ) ,contentSize:CGSize(width: 320, height: 200), style:.actionSheet), animated: true, completion: nil)
        
    }
    @IBAction func onCustom(_ sender: AnyObject) {
        let rootVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModalController")
        let presentAnimator:TransitionAnimator = TransitionAnimator(duration: 0.5, animations: { transitionContext in
            
            guard let contextController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
                return
            }
            guard let modalVc = contextController as? ModalViewController else {
                return
            }
            let containerView = transitionContext.containerView
            containerView.addSubview(modalVc.view)
            modalVc.rootController.view.transform = CGAffineTransform(scaleX: 3, y: 3);
            UIView.animate(withDuration: 0.5, animations: {
                modalVc.overlayView.alpha = 0.4
                modalVc.rootController.view.transform = CGAffineTransform.identity
            }, completion: { (finished) in
                transitionContext.completeTransition(finished)
            })
            
        }, completion: nil)
        let dismissAnimator:TransitionAnimator = TransitionAnimator(duration: 0.5, animations: { transitionContext in
            
            guard let contextController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
                return
            }
            guard let modalVc = contextController as? ModalViewController else {
                return
            }
            let _ = transitionContext.containerView
            UIView.animate(withDuration: 0.5, animations: {
                modalVc.overlayView.alpha = 0
                modalVc.rootController.view.transform = CGAffineTransform(scaleX: 3, y: 3);
            }, completion: { (finished) in
                transitionContext.completeTransition(finished)
            })
            
        }, completion: nil)
        self.present(ModalViewController(rootController:rootVc ,contentSize:CGSize(width: 320, height: 200), presentAnimator:presentAnimator,dismissAnimator:dismissAnimator), animated: true, completion: nil)
        
    }
    
    @IBAction func onCustomNav(_ sender: AnyObject) {
        let rootVc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ModalController")
        let presentAnimator:TransitionAnimator = TransitionAnimator(duration: 0.5, animations: { transitionContext in
            
            guard let contextController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
                return
            }
            guard let modalVc = contextController as? ModalViewController else {
                return
            }
            let containerView = transitionContext.containerView
            containerView.addSubview(modalVc.view)
            modalVc.rootController.view.transform = CGAffineTransform(rotationAngle: -3.14);
            UIView.animate(withDuration: 0.5, animations: {
                modalVc.overlayView.alpha = 0.4
                modalVc.rootController.view.transform = CGAffineTransform.identity
            }, completion: { (finished) in
                transitionContext.completeTransition(finished)
            })
            
        }, completion: nil)
        let dismissAnimator:TransitionAnimator = TransitionAnimator(duration: 0.5, animations: { transitionContext in
            
            guard let contextController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else {
                return
            }
            guard let modalVc = contextController as? ModalViewController else {
                return
            }
            let _ = transitionContext.containerView
            UIView.animate(withDuration: 0.5, animations: {
                modalVc.overlayView.alpha = 0
                modalVc.rootController.view.transform = CGAffineTransform(rotationAngle: 3.14);
            }, completion: { (finished) in
                transitionContext.completeTransition(finished)
            })
            
        }, completion: nil)
        self.present(ModalViewController(rootController:UINavigationController(rootViewController:rootVc ) ,contentSize:CGSize(width: 320, height: 200), presentAnimator:presentAnimator,dismissAnimator:dismissAnimator), animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

