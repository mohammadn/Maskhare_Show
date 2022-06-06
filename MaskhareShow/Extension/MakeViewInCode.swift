//
//  MakeViewprogrammatically.swift
//  DesignPantomime
//
//  Created by mohammad najafzade on 5/29/19.
//  Copyright © 2019 mohammad najafzade. All rights reserved.
//

import Foundation
import UIKit

class MakeViewInCode {
    
    // function for making button
    func buttonFactory( type: UIButton.ButtonType = UIButton.ButtonType.system,  title: String = "Button", titleColor: String = "#EFEFEFFF", backgroundColor: String = "#EFEFEF00", imageName: UIImage? = nil, borderColor: String = "#00000000", borderWidth: CGFloat = 0, maskedCorners: CACornerMask = [] ) -> UIButton {
        
        let button = UIButton(type: type)
        button.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.titleLabel?.textAlignment = NSTextAlignment.center
        button.setTitle(title, for: UIControl.State.normal)
        button.setTitleColor(UIColor(hex: titleColor), for: .normal)
        
        button.backgroundColor = UIColor(hex: backgroundColor)
        button.setImage(imageName , for: .normal)
        button.layer.borderColor = UIColor(hex: borderColor)?.cgColor
        button.layer.borderWidth = borderWidth
        
        button.layer.cornerRadius = 15.0
        button.layer.maskedCorners = maskedCorners
        button.clipsToBounds = true
        
        return button
    }
    
    // function for making label
    func labelFactory( title: String, color: String = "#FFFFFFFF" ) -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.text = title
        label.font = UIFont(name: "ChalkboardSE-Regular", size: 20)
        label.center = CGPoint(x: 160, y: 285)
        label.textAlignment = .center
        label.textColor = UIColor(hex: color)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
    
    // function for making stackview
    func stackViewFactory( axis: NSLayoutConstraint.Axis = NSLayoutConstraint.Axis.vertical, spacing: CGFloat = 0, distribution: UIStackView.Distribution = UIStackView.Distribution.fillEqually ) -> UIStackView {
        
        let stackView = UIStackView()
        stackView.axis = axis
        stackView.alignment = .fill
        stackView.spacing = spacing
        stackView.distribution = distribution
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }
    
    // function for making a list of random number without repeat
    func makeListOfRandomNumber( num: Int, period: Int) -> [Int] {
        
        var listOfNumber = [Int]()
        
        repeat {
            let randomNumber = Int(arc4random_uniform(UInt32(period)))
            
            if listOfNumber.count == 0 {
                listOfNumber.append(randomNumber)
            }
            
            for n in 0...listOfNumber.count {
                
                if randomNumber == listOfNumber[n] {
                    break
                } else if n == listOfNumber.count-1 {
                    listOfNumber.append(randomNumber)
                }
                
            }
        } while listOfNumber.count != num;
        
        return listOfNumber
    }
    
    // function make constraint and add them view
    func constraintsFactory(selfView: AnyObject, containerView: AnyObject? = nil, leftConstantValue: CGFloat = -1, rightConstantValue: CGFloat = -1, heightConstantValue: CGFloat = -1, widthConstantValue: CGFloat = -1) {
        
        if containerView != nil {
            
            // add left constant
            let leftConstant = NSLayoutConstraint(item: selfView, attribute: NSLayoutConstraint.Attribute.leading, relatedBy:      NSLayoutConstraint.Relation.equal, toItem: containerView, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1.0, constant: leftConstantValue)
            if leftConstantValue != -1 {
                containerView!.addConstraint(leftConstant)
            }
            
            // add right constant
            let rightConstant = NSLayoutConstraint(item: selfView, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: containerView, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1.0, constant: rightConstantValue)
            if rightConstantValue != -1 {
                containerView!.addConstraint(rightConstant)
            }
            
        }
        
        
        // add heigh constant
        let heightConstant = NSLayoutConstraint(item: selfView, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: heightConstantValue)
        if heightConstantValue != -1 {
            selfView.addConstraint(heightConstant)
        }
        
        // add width constant
        let widthConstant = NSLayoutConstraint(item: selfView, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 1.0, constant: widthConstantValue)
        
        if widthConstantValue != -1 {
            selfView.addConstraint(widthConstant)
        }
        
    }
    
}
