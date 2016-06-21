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
    case Alert
    case ActionSheet
    case Custom

}

@objc(LTModalViewController)
public class ModalViewController: UIViewController {
    
    private(set) public var rootController:UIViewController = UIViewController()
    
    private(set) public var overlayView: UIControl = UIControl()

    private(set) public var presentedViewSize:CGSize = CGSizeZero
    
    private(set) public var presentStyle:PresentStyle = .Alert

    private(set) public var presentContentInset:CGFloat = 0

    private(set) public var cornerRadius:CGFloat = 0
    
    private(set) public var presentAnimator:TransitionAnimator?
    private(set) public var dismissAnimator:TransitionAnimator?
    
//    public var presentCompletionHandler : ((Void) -> (Void))? not yet implementation
//    public var dismissCompletionHandler : ((Void) -> (Void))? not yet implementation

    public convenience init(rootController controller: UIViewController ,contentSize:CGSize , contentInset:CGFloat = 0 , radius:CGFloat = 0, presentAnimator:TransitionAnimator ,dismissAnimator:TransitionAnimator ) {
        self.init(rootController:controller ,contentSize:contentSize , style:.Custom , contentInset:contentInset , radius:radius)
        self.presentAnimator = presentAnimator
        self.dismissAnimator = dismissAnimator
        self.transitioningDelegate = self
        self.modalPresentationStyle = .Custom
    }

    public convenience init(rootController controller: UIViewController ,contentSize:CGSize , contentInset:CGFloat = 0 , radius:CGFloat = 0 , style:PresentStyle = .Alert ) {
        
        self.init()
        
        self.rootController = controller
        self.presentedViewSize = contentSize
        self.presentStyle = style
        self.presentContentInset = contentInset
        self.cornerRadius = radius
        
        
        self.overlayView.backgroundColor = UIColor.blackColor()
        overlayView.alpha = 0
        overlayView.addTarget(self, action: #selector(touchOverlayView), forControlEvents: .TouchUpInside)
        switch presentStyle {
        case .Alert:
            self.transitioningDelegate = self
            self.modalPresentationStyle = .Custom
            self.presentAnimator = AlertTransitionAnimator.presentAnimator
            self.dismissAnimator = AlertTransitionAnimator.dismissAnimator
        case .ActionSheet:
            self.transitioningDelegate = self
            self.modalPresentationStyle = .Custom
            self.presentAnimator = ActionSheetTransitionAnimator.presentAnimator
            self.dismissAnimator = ActionSheetTransitionAnimator.dismissAnimator
        default: break
        }
        
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clearColor();
        view.autoresizingMask = [.FlexibleWidth,.FlexibleHeight]
        
        view.addSubview(overlayView)
        overlayView.frame  = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height)
        overlayView.autoresizingMask = [.FlexibleWidth,.FlexibleHeight]

        self.addChildViewController(rootController)
        view.addSubview(rootController.view)
        rootController.view.frame = CGRectMake((view.frame.width-presentedViewSize.width)/2, (view.frame.height-presentedViewSize.height)/2 + presentContentInset, presentedViewSize.width, presentedViewSize.height)
        rootController.view.autoresizingMask = [.FlexibleTopMargin,.FlexibleBottomMargin,.FlexibleLeftMargin,.FlexibleRightMargin]
        
        if cornerRadius > 0 {
            rootController.view.layer.masksToBounds = true;
            rootController.view.layer.cornerRadius = cornerRadius;
        }
    }
    
    func touchOverlayView(sender:AnyObject?) -> Void {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
// MARK: - UIViewControllerTransitioningDelegate
extension ModalViewController : UIViewControllerTransitioningDelegate {
    
    public func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.presentAnimator
    }
    
    public func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self.dismissAnimator
    }
}