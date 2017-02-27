//
//  ModalController.swift
//  Example
//
//  Created by Futao on 16/6/21.
//  Copyright © 2016年 Ftkey. All rights reserved.
//

import Foundation
import UIKit

class ModalController : UIViewController {
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func onDissmiss(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}
