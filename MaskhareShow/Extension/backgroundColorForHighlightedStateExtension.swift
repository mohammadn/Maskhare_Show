//
//  backgroundColorForHighlightedStateExtension.swift
//  DesignPantomime
//
//  Created by mohammad najafzade on 5/25/19.
//  Copyright © 2019 mohammad najafzade. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func setBackgroundColor(view: [AnyObject], color: UIColor, forState: UIControl.State) {
        for index in view {
            UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
            if let context = UIGraphicsGetCurrentContext() {
                context.setFillColor(color.cgColor)
                context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
                let colorImage = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                index.setBackgroundImage(colorImage, for: forState)
            }
        }
        
    }
}
