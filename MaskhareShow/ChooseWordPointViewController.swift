//
//  ChooseWordPointViewController.swift
//  DesignPantomime
//
//  Created by mohammad najafzade on 5/29/19.
//  Copyright © 2019 mohammad najafzade. All rights reserved.
//

import UIKit

class ChooseWordPointViewController: UIViewController {

    @IBOutlet var pointsButtons: [UIButton]!
    @IBOutlet weak var confirmButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Design View Controller
        
        CALayer().addBorderRadius([confirmButton, pointsButtons[0], pointsButtons[2]], 15)
        CALayer().addMaskedCorners([pointsButtons[0]], [.layerMaxXMinYCorner])
        CALayer().addMaskedCorners([pointsButtons[2]], [.layerMinXMinYCorner])
        CALayer().addMaskedCorners([confirmButton], [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        
        confirmButton.isEnabled = false
        confirmButton.backgroundColor = UIColor.lightGray
        
        // locked pickedCategory
        
        for (groupName,_) in getVariables.pickedCategory {
            if groupName == getVariables.groupTurn {
                for (category,points) in getVariables.pickedCategory[groupName]! {
                    if category == getVariables.selectedWord {
                        for point in points {
                            if point == 2 {
                                pointsButtons[0].isEnabled = false
                                pointsButtons[0].backgroundColor = UIColor.lightGray
                            }
                            if point == 4 {
                                pointsButtons[1].isEnabled = false
                                pointsButtons[1].backgroundColor = UIColor.lightGray
                            }
                            if point == 6 {
                                pointsButtons[2].isEnabled = false
                                pointsButtons[2].backgroundColor = UIColor.lightGray
                            }
                        }
                    }
                }
                break
            }
        }
        
        
    }
    
    @IBAction func pointButtonClicked(_ sender: AnyObject) {
        for i in 0...pointsButtons.count-1 {
            if sender === pointsButtons[i] {
                
                UIView.animate(withDuration: 0.4) {
                    self.pointsButtons[i].layer.backgroundColor = UIColor(hex: "#F39F2BFF")?.cgColor
                    self.confirmButton.backgroundColor = UIColor(hex: "#F39F2BFF")
                    self.confirmButton.isEnabled = true
                }
                
                getVariables.pointOfWord = (i*2)+2
            } else if pointsButtons[i].isEnabled {
                
                pointsButtons[i].layer.backgroundColor = UIColor(hex: "#EED9CBFF")?.cgColor
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is ShowWordViewController {
            let destinationView = segue.destination as! ShowWordViewController
            destinationView.hero.modalAnimationType = .slide(direction: .up)
        }
        
    }

}
