//
//  ChooseNameViewController.swift
//  DesignPantomime
//
//  Created by mohammad najafzade on 5/28/19.
//  Copyright © 2019 mohammad najafzade. All rights reserved.
//

import UIKit
import AIFlatSwitch


class ChoosePersonNameViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var personsName: [AIFlatSwitch]!
    @IBOutlet var personsNameLabel: [UILabel]!
    @IBOutlet var stackviews: [UIStackView]!
    
    var selectedGroup = 0
//    let sampleTextField =  UITextField(frame: CGRect(x: 20, y: 100, width: 300, height: 40))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // test for change name feature
        
//        sampleTextField.font = UIFont.systemFont(ofSize: 15)
//        sampleTextField.borderStyle = UITextField.BorderStyle.roundedRect
//        sampleTextField.autocorrectionType = UITextAutocorrectionType.no
//        sampleTextField.keyboardType = UIKeyboardType.default
//        sampleTextField.returnKeyType = UIReturnKeyType.done
//        sampleTextField.clearButtonMode = UITextField.ViewMode.whileEditing
//        sampleTextField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
//        sampleTextField.delegate = self
//
//        personsNameLabel[0].isUserInteractionEnabled = true
//        let aSelector : Selector = "lblTapped"
//        let tapGesture = UITapGestureRecognizer(target: self, action: aSelector)
//        tapGesture.numberOfTapsRequired = 1
//        personsNameLabel[0].addGestureRecognizer(tapGesture)
        
        // show previous selected name
        for personName in personsName {
            for index in getVariables.selectedNames[selectedGroup] {
                if personName.accessibilityLabel! == index {
                    personName.isSelected = true
                }
            }
        }
        
    }
    
    // change name feature
    
//    @objc func lblTapped() {
//
//        personsNameLabel[0].isHidden = true
//        sampleTextField.text = personsNameLabel[0].text
//
//
//        self.stackviews[0].addArrangedSubview(sampleTextField)
//
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//
//        textField.resignFirstResponder()
//        personsNameLabel[0].text = sampleTextField.text
//        sampleTextField.removeFromSuperview()
//        personsNameLabel[0].isHidden = false
//        return true
//
//    }
    
    // config switches button to remove or add names to selectedName array
    @IBAction func switches(_ sender: AnyObject) {
        
        for n in 0...personsName.count-1 {
            
            if personsName[n] === sender {
                
                if getVariables.selectedNames[selectedGroup].count == 0 {
                    
                    getVariables.selectedNames[selectedGroup].append(personsName[n].accessibilityLabel!)
                    
                } else {
                    
                    for i in 0...getVariables.selectedNames[selectedGroup].count-1 {
                        
                        if personsName[n].accessibilityLabel! == getVariables.selectedNames[selectedGroup][i] {
                            
                            getVariables.selectedNames[selectedGroup].remove(at: i)
                            break
                            
                        } else if i == getVariables.selectedNames[selectedGroup].count-1 {
                            
                            getVariables.selectedNames[selectedGroup].append(personsName[n].accessibilityLabel!)
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}
