//
//  ChooseWordViewController.swift
//  DesignPantomime
//
//  Created by mohammad najafzade on 5/29/19.
//  Copyright © 2019 mohammad najafzade. All rights reserved.
//

import UIKit
import Hero

class ChooseCategoryViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var wordsButton: UIButton!
    @IBOutlet weak var expressionButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Design View Controller
        
        CALayer().addBorderRadius([backButton, wordsButton, expressionButton], 15)
        
        // 1. backButton style
        CALayer().addBorder([backButton], "#F44336FF", 3)
        UIButton().setBackgroundColor(view: [backButton], color: UIColor(hex: "#F44336FF")!, forState: .highlighted)
        
        // 2. words and expression style
        CALayer().addMaskedCorners([wordsButton], [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        CALayer().addMaskedCorners([expressionButton], [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        
    }
    
    @IBAction func expressionButtonClicked(_ sender: Any) {
        getVariables.selectedWord = "ضرب المثل"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is ScoreBoardViewController {
            let destinationView = segue.destination as! ScoreBoardViewController
            destinationView.hero.modalAnimationType = .zoomSlide(direction: .right)
        }
        
    }
}
