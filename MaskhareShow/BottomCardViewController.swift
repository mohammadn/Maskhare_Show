//
//  BottomCardViewController.swift
//  DesignPantomime
//
//  Created by mohammad najafzade on 5/25/19.
//  Copyright © 2019 mohammad najafzade. All rights reserved.
//

import UIKit
import Hero

class BottomCardViewController: UIViewController {
    
    @IBOutlet var numberButtons: [UIButton]!
    @IBOutlet weak var confirmButton: UIButton!
    
    var model = WordsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Design View Controller
        
        CALayer().addBorderRadius([confirmButton, numberButtons[0], numberButtons[2]], 15)
        CALayer().addMaskedCorners([numberButtons[0]], [.layerMaxXMinYCorner])
        CALayer().addMaskedCorners([numberButtons[2]], [.layerMinXMinYCorner])
        CALayer().addMaskedCorners([confirmButton], [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        
        confirmButton.isEnabled = false
        confirmButton.backgroundColor = UIColor.lightGray
        
    }    

    // choose number of group action
    @IBAction func numberButton(_ sender: AnyObject) {
        for i in 0...numberButtons.count-1 {
            if sender === numberButtons[i] {
                
                UIView.animate(withDuration: 0.4) {
                    self.numberButtons[i].layer.backgroundColor = UIColor(hex: "#F39F2BFF")?.cgColor
                    self.confirmButton.backgroundColor = UIColor(hex: "#F39F2BFF")
                    self.confirmButton.isEnabled = true
                }
                
                getVariables.numberOfGroups = i+2
            } else {
                numberButtons[i].layer.backgroundColor = UIColor(hex: "#EED9CBFF")?.cgColor
            }
        }
        resetGameVariables()
    }
    
    func resetGameVariables() {
        getVariables.pickedCategory = [:]
        getVariables.groupButtons = [UIButton]()
        getVariables.selectedGroupsName = []
        getVariables.selectedNames = Array(repeating: Array(repeating: "", count: 0), count: getVariables.numberOfGroups)
        getVariables.scoreLabels = []
        getVariables.wordsArray = model.getWord()
    }
    
    // config segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showGameSetup" {
            let destinationView = segue.destination as! GameSetupViewController
            destinationView.hero.modalAnimationType = .zoomSlide(direction: .left)
            
        }
        
    }
    
}
