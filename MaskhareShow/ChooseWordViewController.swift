//
//  ChooseWordViewController.swift
//  DesignPantomime
//
//  Created by mohammad najafzade on 5/29/19.
//  Copyright © 2019 mohammad najafzade. All rights reserved.
//

import UIKit
import Hero

class ChooseWordViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet var wordsButtons: [UIButton]!
    @IBOutlet weak var playerTurn: UILabel!
    @IBOutlet weak var playerTurnName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Design View Controller
        
        // 1. backButton style
        CALayer().addBorder([backButton], "#EED9CBFF", 3)
        CALayer().addBorderRadius([backButton], 15)
        UIButton().setBackgroundColor(view: [backButton], color: UIColor(hex: "#F44336FF")!, forState: .highlighted)

        // 2. playerTurn and playerTurnName
        CALayer().addBorderRadius([playerTurn,playerTurnName], 10)
        CALayer().addMaskedCorners([playerTurn], [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        CALayer().addMaskedCorners([playerTurnName], [.layerMinXMinYCorner, .layerMinXMaxYCorner])
        
        // 3. config playerTurnName
        playerTurnName.text = "\(getVariables.playerTurn!) از \(getVariables.groupTurn!)"
        
        // easterEgg
        if getVariables.easterEgg == 51 {
            
            wordsButtons[10].setBackgroundColor(view: [wordsButtons[10]], color: UIColor(hex: "#2A2B47FF")!, forState: .normal)
            wordsButtons[10].setImage( nil, for: .normal)
        }
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func wordClicked(_ sender: AnyObject) {
        for index in wordsButtons {
            if sender as! NSObject == index {
                
                if  index.titleLabel!.text! == "بامزه" && getVariables.easterEgg == 51 {
                
                    getVariables.selectedWord = index.titleLabel?.text
                    performSegue(withIdentifier: "showPointOfWord", sender: nil)
                    
                } else if  index.titleLabel!.text! == "بامزه" && getVariables.easterEgg == 50 {
                    
                    wordsButtons[10].setBackgroundColor(view: [wordsButtons[10]], color: UIColor(hex: "#2A2B47FF")!, forState: .normal)
                    wordsButtons[10].setImage( nil, for: .normal)
                    GameSetupViewController().warningAlert("فقط چون خیلی پیگیری!!")
                    getVariables.easterEgg += 1
                    
                } else if index.titleLabel!.text! == "بامزه" {
                    
                    getVariables.easterEgg += 1
                    
                } else {
                    
                    getVariables.selectedWord = index.titleLabel?.text
                    performSegue(withIdentifier: "showPointOfWord", sender: nil)
                    
                }
                
            }
        }
        
    }
    
}
