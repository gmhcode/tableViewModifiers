//
//  alertExtension.swift
//  tableViewModifiers
//
//  Created by Greg Hughes on 5/22/19.
//  Copyright © 2019 Greg Hughes. All rights reserved.
//

import UIKit
public extension UIAlertController {
    
    func show() {
        DispatchQueue.main.async {
            let win = UIWindow(frame: UIScreen.main.bounds)
            let vc = UIViewController()
            vc.view.backgroundColor = .clear
            win.rootViewController = vc
            win.windowLevel = UIWindow.Level.alert + 1
            win.makeKeyAndVisible()
            vc.present(self, animated: true, completion: nil)
        }
        
    }
}
