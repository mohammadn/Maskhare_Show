//
//  GuessingStatusViewController.swift
//  DesignPantomime
//
//  Created by mohammad najafzade on 5/31/19.
//  Copyright © 2019 mohammad najafzade. All rights reserved.
//

import UIKit

class GuessingStatusViewController: UIViewController {

    @IBOutlet weak var guessingView: UIView!
    @IBOutlet var correctWrongButtons: [UIButton]!
    
    @IBOutlet weak var warningView: UIView!
    @IBOutlet var mistakesPoint: [UIButton]!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var sumPoint: UILabel!
    
    var mistakesPointStatus = [false, false, false]
    var gameCounterPoint = 0
    var wordPoint = 0
    var wordChanged = 0
    var mistakePoint = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Design View Controller
        
        // 1. correctWrongButtons
        CALayer().addBorderRadius([correctWrongButtons[0], correctWrongButtons[1]], 15)
        CALayer().addMaskedCorners([correctWrongButtons[1]], [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        CALayer().addMaskedCorners([correctWrongButtons[0]], [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        
        // 2. mistakesPoint and confirmButton
        CALayer().addBorderRadius([mistakesPoint[0], mistakesPoint[2], confirmButton], 15)
        CALayer().addMaskedCorners([mistakesPoint[0]], [.layerMaxXMinYCorner])
        CALayer().addMaskedCorners([mistakesPoint[2]], [.layerMinXMinYCorner])
        CALayer().addMaskedCorners([confirmButton], [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        
    }
    
    @IBAction func wrongButton(_ sender: Any) {

        UIView.transition(from: guessingView, to: warningView, duration: 0.9, options: .transitionFlipFromTop, completion: nil)
        wordPoint = 0 - wordChanged
        gameCounterPoint = 0
        updateSumPointLabel()
        
    }
    
    @IBAction func correctButton(_ sender: Any) {
        
        UIView.transition(from: guessingView, to: warningView, duration: 0.9, options: .transitionFlipFromTop, completion: nil)
        wordPoint = getVariables.pointOfWord - wordChanged
        updateSumPointLabel()
    }
    
    @IBAction func mistakesPoint(_ sender: AnyObject) {
        
        for i in 0...mistakesPoint.count-1 {
            
            if sender === mistakesPoint[i] {
                
                if mistakesPointStatus[i] == false {
                    
                    UIView.animate(withDuration: 0.4) {
                        self.mistakesPoint[i].layer.backgroundColor = UIColor(hex: "#F39F2BFF")?.cgColor
                    }
                    mistakePoint = i+1
                    
                    updateSumPointLabel()
                    
                    mistakesPointStatus[i] = true
                    
                } else {
                    
                    mistakesPoint[i].layer.backgroundColor = UIColor(hex: "#2A2B47FF")?.cgColor
                    
                    mistakePoint = 0
                    
                    updateSumPointLabel()
                    
                    mistakesPointStatus[i] = false
                    
                }
                
            } else {
                
                mistakesPoint[i].layer.backgroundColor = UIColor(hex: "#2A2B47FF")?.cgColor
                mistakesPointStatus[i] = false
                
            }
        }
    }
    
    @IBAction func confirmButton(_ sender: Any) {
        getVariables.nextLabel.text = "\(wordPoint) + \(gameCounterPoint) - \(mistakePoint)"
        getVariables.sumLabel.text = "\(Int(getVariables.sumLabel.text!)! + wordPoint + gameCounterPoint - mistakePoint)"
        getVariables.scoreBoardStatusGaurdian = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is ScoreBoardViewController {
            let destinationView = segue.destination as! ScoreBoardViewController
            destinationView.hero.modalAnimationType = .zoomSlide(direction: .right)
        }
        
    }
    
    func updateSumPointLabel() {
        UIView.transition(with: sumPoint, duration: 0.1, options: .transitionCrossDissolve, animations: {
            
            self.sumPoint.text = "\(self.wordPoint) + \(self.gameCounterPoint) - \(self.mistakePoint) = \(self.wordPoint + self.gameCounterPoint - self.mistakePoint)"
            
        }, completion: nil)
    }
}
