//
//  GameSetupViewController.swift
//  DesignPantomime
//
//  Created by mohammad najafzade on 5/26/19.
//  Copyright © 2019 mohammad najafzade. All rights reserved.
//

import UIKit
import SwiftMessages
import TGPControls
import Hero


class GameSetupViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var groupsInfoStackView: UIStackView!
    @IBOutlet weak var camelLabels: TGPCamelLabels!
    @IBOutlet weak var discreteSlider: TGPDiscreteSlider!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var startGame: UIButton!
    
    let groupsName = ["شقایق های زیبا", "خشگل های فامیل به جز شهین", "قاصدک ها", "یوگی و دوستان", "شکوفه های بارانی", "قلمرو عقاب ها", "مدرسه موش ها", "عشقولیا", "شنگول منگول حبه انگور"]
    
    
    var groupInfoButtons = [UIButton]()
    var selectedGroupForEdit = 0
    
    var selectedGroupNameCheck = false
    var selectedNameCheck = false

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let makeView = MakeViewInCode()
        
        
        // make main StackView for buttons and add constraints to itself
        let mainStackView = makeView.stackViewFactory(spacing: 20 )
        groupsInfoStackView.addArrangedSubview(mainStackView)
        mainStackView.leadingAnchor.constraint(equalTo: groupsInfoStackView.leadingAnchor, constant: 40).isActive = true
        mainStackView.trailingAnchor.constraint(equalTo: groupsInfoStackView.trailingAnchor, constant: -40).isActive = true
        
        
        //make a random Number List for getting random name from groupsName array and add thos name to getVariables.selectedGroupsName
        let randomNameIndexNumber = makeView.makeListOfRandomNumber(num: getVariables.numberOfGroups, period: groupsName.count)
        for index in randomNameIndexNumber {
            getVariables.selectedGroupsName.append(groupsName[index])
        }
        
        // make group Button
        for n in 0...getVariables.numberOfGroups-1 {
            
            // generate buttons and stackview
            let generatedGroupButton = makeView.buttonFactory(title: getVariables.selectedGroupsName[n], titleColor: "#EFEFEFFF", backgroundColor: "#699965FF", maskedCorners: [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
            generatedGroupButton.addTarget(self, action: #selector(GameSetupViewController.groupButtonClicked(_:)), for: .touchUpInside)
            
            let generatedGroupInfoButton = makeView.buttonFactory(type: UIButton.ButtonType.custom, title: "", imageName: UIImage(named: "edit"), borderColor: "#DE343DFF", borderWidth: 5, maskedCorners: [.layerMinXMinYCorner, .layerMinXMaxYCorner])
            UIButton().setBackgroundColor(view: [generatedGroupInfoButton], color: UIColor(hex: "#DE343DFF")!, forState: .highlighted)
            generatedGroupInfoButton.setImage(UIImage(named: "clickedEdit"), for: .highlighted)
            generatedGroupInfoButton.addTarget(self, action: #selector(GameSetupViewController.groupInfoButtonClicked(_:)), for: .touchUpInside)
            
            let generatedStackView = makeView.stackViewFactory(axis: NSLayoutConstraint.Axis.horizontal, spacing: 5, distribution: UIStackView.Distribution.fill)
            
            // append buttons to their storage
            getVariables.groupButtons.append(generatedGroupButton)
            groupInfoButtons.append(generatedGroupInfoButton)
            
            // add buttons and stackviews to view
            generatedStackView.addArrangedSubview(generatedGroupInfoButton)
            generatedStackView.addArrangedSubview(generatedGroupButton)
            mainStackView.addArrangedSubview(generatedStackView)
            
            // add constraints and generatedGroupInfoButton
            makeView.constraintsFactory(selfView: generatedGroupInfoButton, heightConstantValue: 75, widthConstantValue: 75)
        }
        
        // MARK: Design View Controller
        
        // 1. backButton style
        CALayer().addBorder([backButton], "#2A2B47FF", 3)
        CALayer().addBorderRadius([backButton, startGame], 15)
        UIButton().setBackgroundColor(view: [backButton], color: UIColor(hex: "#2A2B47FF")!, forState: .highlighted)
        
        // config Slider
        discreteSlider.ticksListener = camelLabels
        discreteSlider.addTarget(self, action: #selector(valueChanged(_:event:)), for: .valueChanged)
        
    }
    
    @IBAction func StartGame(_ sender: Any) {
        
        for index in getVariables.selectedNames {
            
            if index.count <= 1 {
                
                warningAlert("لطفا تعداد افراد هر گروه رو با انتخاب اسمشون مشخص کن (برای هر تیم حداقل دو نفر)")
                selectedNameCheck = false
                break
                
            } else if index == getVariables.selectedNames[getVariables.selectedNames.count-1] {
                
                selectedNameCheck = true
                
            }
        
        }
        
        outer: for n in 0...getVariables.selectedGroupsName.count-1 {
            for i in 0...getVariables.selectedGroupsName.count-1 {
                if getVariables.selectedGroupsName[n] == getVariables.selectedGroupsName[i] && i != n{
                    warningAlert("اسامی گروه ها نمی تونند شبیه هم باشند.")
                    selectedGroupNameCheck = false
                    break outer
                } else if n == getVariables.selectedGroupsName.count-1 {
                    selectedGroupNameCheck = true
                }
            }
        }
        
        if selectedGroupNameCheck == true && selectedNameCheck == true {
            
            for index in getVariables.selectedGroupsName {
                getVariables.pickedCategory[index] = [String: [Int]]()
            }
            
            getVariables.scoreBoardStatus = false
            performSegue(withIdentifier: "showScoreBoard", sender: nil)
            
        }
        
    }
    
    // action for groupButton
    @objc func groupButtonClicked(_ sender: AnyObject?){
        
        for n in 0...getVariables.groupButtons.count-1 {
            if getVariables.groupButtons[n] === sender {
                selectedGroupForEdit = n
            }
        }
        performSegue(withIdentifier: "showChooseGroupName", sender: nil)
        
    }
    
    // action for groupInfoButton
    @objc func groupInfoButtonClicked(_ sender: AnyObject?){
        
        for n in 0...groupInfoButtons.count-1 {
            if groupInfoButtons[n] === sender {
                selectedGroupForEdit = n
            }
        }
        performSegue(withIdentifier: "showChoosePersonName", sender: nil)
        
    }
    
    @objc func valueChanged(_ sender: TGPDiscreteSlider, event:UIEvent) {
        
        getVariables.numberOfRounds = Int(sender.value)
        
    }
    
    // config segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is ChoosePersonNameViewController {
            let destinationView = segue.destination as? ChoosePersonNameViewController
            destinationView?.selectedGroup = selectedGroupForEdit
        }
        
        if segue.destination is ChooseGroupNameViewController {
            let destinationView = segue.destination as? ChooseGroupNameViewController
            destinationView?.groupsName = groupsName
            destinationView?.selectedGroup = selectedGroupForEdit
        }
        
        if segue.destination is ScoreBoardViewController {
            let destinationView = segue.destination as! ScoreBoardViewController
            destinationView.hero.modalAnimationType = .zoom
        }
        
        if segue.identifier == "backButton" {
            let destinationView = segue.destination as! ModesViewController
            destinationView.hero.modalAnimationType = .zoomSlide(direction: .right)
        }
    }
    
    
    func warningAlert(_ message: String) {
        let warningView = MessageView.viewFromNib(layout: .centeredView)
        var config = SwiftMessages.defaultConfig
        
        // Theme message elements with the warning style.
        warningView.configureTheme(.error)
        
        // custom Config
        warningView.bodyLabel?.textAlignment = .center
        warningView.bodyLabel?.font = UIFont.systemFont(ofSize: 15)
        warningView.button?.removeFromSuperview()
        config.duration = .seconds(seconds: 5)
        
        // Add a drop shadow.
        warningView.configureDropShadow()
        
        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
        warningView.configureContent(title: nil, body:  message, iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: nil, buttonTapHandler: nil)
        
       
        // Increase the external margin around the card. In general, the effect of this setting
        // depends on how the given layout is constrained to the layout margins.
        warningView.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        // Reduce the corner radius (applicable to layouts featuring rounded corners).
        (warningView.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        
        // Show the message.
        SwiftMessages.show(view: warningView)
    }
    
}
