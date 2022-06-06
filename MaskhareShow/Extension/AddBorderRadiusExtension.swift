//
//  File.swift
//  DesignPantomime
//
//  Created by mohammad najafzade on 5/25/19.
//  Copyright © 2019 mohammad najafzade. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 13.0, *)

extension CALayer {
    
    func addBorderRadius(_ view: [AnyObject], _ radius: Int) {
        
        for index in view{
            
            index.layer.cornerRadius = CGFloat(radius)
            
        }
        
    }
    
    func addMaskedCorners(_ view: [AnyObject], _ corners: CACornerMask) {
        
        for index in view {
            
            index.layer?.maskedCorners = corners
            
        }
        
    }

    func addBorder(_ view: [AnyObject], _ color: String, _ width: Int)  {
        
        for index in view {
            
            index.layer.borderColor = UIColor(hex: color)?.cgColor
            index.layer.borderWidth = CGFloat(width)
            
        }
        
    }
    
}
