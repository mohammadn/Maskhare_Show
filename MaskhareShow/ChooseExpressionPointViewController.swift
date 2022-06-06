//
//  ChooseExpressionPointViewController.swift
//  DesignPantomime
//
//  Created by mohammad najafzade on 5/29/19.
//  Copyright © 2019 mohammad najafzade. All rights reserved.
//

import UIKit

class ChooseExpressionPointViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet var expressionPoints: [UIButton]!
    @IBOutlet weak var playerTurn: UILabel!
    @IBOutlet weak var playerTurnName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Design View Controller
        
        // 1. backButton style
        CALayer().addBorder([backButton], "#EED9CBFF", 3)
        CALayer().addBorderRadius([backButton], 15)
        UIButton().setBackgroundColor(view: [backButton], color: UIColor(hex: "#EED9CBFF")!, forState: .highlighted)
        
        // 2. expression point style
        CALayer().addBorderRadius([expressionPoints[0],expressionPoints[2]], 15)
        CALayer().addMaskedCorners([expressionPoints[0]], [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        CALayer().addMaskedCorners([expressionPoints[2]], [.layerMinXMinYCorner, .layerMinXMaxYCorner])
        
        // 3. playerTurn and playerTurnName
        CALayer().addBorderRadius([playerTurn,playerTurnName], 10)
        CALayer().addMaskedCorners([playerTurn], [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        CALayer().addMaskedCorners([playerTurnName], [.layerMinXMinYCorner, .layerMinXMaxYCorner])
     
        // 4. config playerTurnName
        playerTurnName.text = "\(getVariables.playerTurn!) از \(getVariables.groupTurn!)"
        
        // 5. locked pickedCategory
        for (groupName,_) in getVariables.pickedCategory {
            if groupName == getVariables.groupTurn {
                for (category,points) in getVariables.pickedCategory[groupName]! {
                    if category == getVariables.selectedWord {
                        for point in points {
                            if point == 3 {
                                expressionPoints[0].isEnabled = false
                                expressionPoints[0].backgroundColor = UIColor.lightGray
                            }
                            if point == 5 {
                                expressionPoints[1].isEnabled = false
                                expressionPoints[1].backgroundColor = UIColor.lightGray
                            }
                            if point == 7 {
                                expressionPoints[2].isEnabled = false
                                expressionPoints[2].backgroundColor = UIColor.lightGray
                            }
                        }
                    }
                }
                break
            }
        }
    
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func expressionPointClicked(_ sender: AnyObject) {
        for i in 0...expressionPoints.count-1 {
            if sender === expressionPoints[i] {
               
                getVariables.pointOfWord = (i*2)+3
            
            }
        }
        performSegue(withIdentifier: "showShowWordView", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is ShowWordViewController {
            let destinationView = segue.destination as! ShowWordViewController
            destinationView.hero.modalAnimationType = .zoomSlide(direction: .left)
        }
        
    }
}
