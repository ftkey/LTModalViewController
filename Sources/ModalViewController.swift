//
//  ModalController.swift
//  ModalViewController
//
//  Created by Futao on 16/6/21.
//
//

import Foundation
import UIKit

@objc(LTModalViewControllerPresentStyle)
public enum PresentStyle:Int {
    case alert
    case actionSheet
    case custom

}

@objc(LTModalViewController)
open class ModalViewController: UIViewController {
    
    fileprivate(set) open var rootController:UIViewController = UIViewController()
    
    fileprivate(set) open var overlayView: UIControl = UIControl()

    fileprivate(set) open var presentedViewSize:CGSize = CGSize.zero
    
    fileprivate(set) open var presentStyle:PresentStyle = .alert

    fileprivate(set) open var presentContentInset:CGFloat = 0

    fileprivate(set) open var cornerRadius:CGFloat = 0
    
    fileprivate(set) open var presentAnimator:TransitionAnimator?
    fileprivate(set) open var dismissAnimator:TransitionAnimator?
    
//    public var presentCompletionHandler : ((Void) -> (Void))? not yet implementation
//    public var dismissCompletionHandler : ((Void) -> (Void))? not yet implementation

    public convenience init(rootController controller: UIViewController ,contentSize:CGSize , contentInset:CGFloat = 0 , radius:CGFloat = 0, presentAnimator:TransitionAnimator ,dismissAnimator:TransitionAnimator ) {
        self.init(rootController:controller ,contentSize:contentSize , contentInset:contentInset , radius:radius , style:.custom)
        self.presentAnimator = presentAnimator
        self.dismissAnimator = dismissAnimator
        self.transitioningDelegate = self
        self.modalPresentationStyle = .custom
    }

    public convenience init(rootController controller: UIViewController ,contentSize:CGSize , contentInset:CGFloat = 0 , radius:CGFloat = 0 , style:PresentStyle = .alert ) {
        
        self.init()
        
        self.rootController = controller
        self.presentedViewSize = contentSize
        self.presentStyle = style
        self.presentContentInset = contentInset
        self.cornerRadius = radius
        
        
        self.overlayView.backgroundColor = UIColor.black
        overlayView.alpha = 0
        overlayView.addTarget(self, action: #selector(touchOverlayView), for: .touchUpInside)
        switch presentStyle {
        case .alert:
            self.transitioningDelegate = self
            self.modalPresentationStyle = .custom
            self.presentAnimator = AlertTransitionAnimator.presentAnimator
            self.dismissAnimator = AlertTransitionAnimator.dismissAnimator
        case .actionSheet:
            self.transitioningDelegate = self
            self.modalPresentationStyle = .custom
            self.presentAnimator = ActionSheetTransitionAnimator.presentAnimator
            self.dismissAnimator = ActionSheetTransitionAnimator.dismissAnimator
        default: break
        }
        
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear;
        view.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        
        view.addSubview(overlayView)
        overlayView.frame  = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        overlayView.autoresizingMask = [.flexibleWidth,.flexibleHeight]

        self.addChildViewController(rootController)
        view.addSubview(rootController.view)
        rootController.view.frame = CGRect(x: (view.frame.width-presentedViewSize.width)/2, y: (view.frame.height-presentedViewSize.height)/2 + presentContentInset, width: presentedViewSize.width, height: presentedViewSize.height)
        rootController.view.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin,.flexibleLeftMargin,.flexibleRightMargin]
        
        if cornerRadius > 0 {
            rootController.view.layer.masksToBounds = true;
            rootController.view.layer.cornerRadius = cornerRadius;
        }
    }
    
    @objc func touchOverlayView(_ sender:AnyObject?) -> Void {
        self.dismiss(animated: true, completion: nil)
    }
}
// MARK: - UIViewControllerTransitioningDelegate
extension ModalViewController : UIViewControllerTransitioningDelegate {
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.presentAnimator
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.dismissAnimator
    }
}
