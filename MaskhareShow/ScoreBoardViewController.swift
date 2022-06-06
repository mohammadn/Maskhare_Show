//
//  ScoreBoardViewController.swift
//  DesignPantomime
//
//  Created by mohammad najafzade on 5/29/19.
//  Copyright © 2019 mohammad najafzade. All rights reserved.
//

import UIKit
import Hero
import SwiftMessages

class ScoreBoardViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var continueButton: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // MARK: Design View Controller
        
        // design BackButton
        CALayer().addBorder([backButton], "#FFFFFFFF", 3)
        CALayer().addBorderRadius([backButton], 15)
        UIButton().setBackgroundColor(view: [backButton], color: UIColor(hex: "#FFFFFFFF")!, forState: .highlighted)
        
        //design ContinueButton
        CALayer().addBorderRadius([continueButton], 15)
        
        
        // make View
        let makeView = MakeViewInCode()
        
        // 1. make scoreBoardStackView for labels
        let scoreBoardStackView = makeView.stackViewFactory(spacing: 20)
        scrollView.addSubview(scoreBoardStackView)
        
        scoreBoardStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scoreBoardStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scoreBoardStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scoreBoardStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        
        if getVariables.scoreBoardStatus == false {
            // make group Button
            for n in 0...getVariables.numberOfRounds+1 {
                
                var generatedLabel = UILabel()
                
                
                // make getVariables.scoreLabels ready for adding label
                getVariables.scoreLabels.append([])
                
                // generate labels and add them to their stackView and append them to their storage
                for i in 0...getVariables.numberOfGroups-1 {
                    
                    if n == 0 {
                        
                        generatedLabel = makeView.labelFactory(title: getVariables.selectedGroupsName[i])
                        generatedLabel.addBorders(edges: .bottom, color: UIColor(hex: "#EED9CBFF")!, width: 1)
                        
                        
                    } else if n == getVariables.numberOfRounds+1{
                        
                        generatedLabel = makeView.labelFactory(title: "0")
                        
                    } else {
                        
                        generatedLabel = makeView.labelFactory(title: "_")
                        
                    }
                    
                    makeView.constraintsFactory(selfView: generatedLabel, heightConstantValue: 30)
                    getVariables.scoreLabels[n].append(generatedLabel)
                }
                
                // finally add to real view
                getVariables.scoreBoardStatus = true
            }
            
            // initialize first Label
            getVariables.scoreLabels[1][0].backgroundColor = UIColor(hex: "#EED9CBFF")
            getVariables.scoreLabels[1][0].textColor = UIColor.black
            getVariables.nextLabel = getVariables.scoreLabels[1][0]
            getVariables.sumLabel = getVariables.scoreLabels[getVariables.scoreLabels.count-1][0]
            // getVariables
            getVariables.groupTurn = getVariables.selectedGroupsName[0]
            getVariables.playerTurn = getVariables.selectedNames[0][0]
            
        } else if getVariables.scoreBoardStatusGaurdian == true {
                outer: for n in 1...getVariables.scoreLabels.count-2 {
                    for i in 0...getVariables.scoreLabels[n].count-1 {
                        if getVariables.scoreLabels[n][i].text! == "_" {
                            getVariables.scoreLabels[n][i].backgroundColor = UIColor(hex: "#EED9CBFF")
                            getVariables.scoreLabels[n][i].textColor = UIColor.black
                            getVariables.nextLabel = getVariables.scoreLabels[n][i]
                            getVariables.sumLabel = getVariables.scoreLabels[getVariables.scoreLabels.count-1][i]
                            getVariables.groupTurn = getVariables.selectedGroupsName[i]
                            getVariables.playerTurn = getVariables.selectedNames[i][(n-1)%getVariables.selectedNames[i].count]
                            break outer
                        }
                    }
                }
                if getVariables.scoreLabels[getVariables.scoreLabels.count-2][getVariables.numberOfGroups-1].text != "_" && getVariables.scoreLabels[getVariables.scoreLabels.count-2][getVariables.numberOfGroups-1].text != "*"{
                    continueButton.setTitle("شروع بازی جدید", for: .normal)
                    
                }
                getVariables.scoreBoardStatusGaurdian = false
            
        }
        
        // show labels on view
        for n in 0...getVariables.scoreLabels.count-1 {
            
            // generate stackView
            let generatedStackView = makeView.stackViewFactory(axis: NSLayoutConstraint.Axis.horizontal, spacing: 10, distribution: UIStackView.Distribution.fillEqually)
            
            // add labels to generatedStackView
            for i in 0...getVariables.scoreLabels[n].count-1 {
                
                generatedStackView.addArrangedSubview(getVariables.scoreLabels[n][i])
            }
            
            // add a border to top of sum number
            if n == getVariables.numberOfRounds+1{
                
                generatedStackView.addBorders(edges: .top, color: UIColor(hex: "#EED9CBFF")!, width: 3)
                
            }
            
            // finally add to real view
            scoreBoardStackView.addArrangedSubview(generatedStackView)
        }
        
        
    }
    
    // config backbutton to show an alert before exit
    @IBAction func backButton(_ sender: Any) {
        cautionAlert()
    }
    
    @IBAction func continueButton(_ sender: Any) {
        if continueButton.titleLabel?.text == "ادامه بازی" {
            
            performSegue(withIdentifier: "showChooseCategory", sender: nil)
        } else {
            
            performSegue(withIdentifier: "backToModes", sender: nil)
        }
    }
    
    // config segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is ModesViewController {
            let destinationView = segue.destination as! ModesViewController
            destinationView.hero.modalAnimationType = .zoomOut
        }
        
        if segue.destination is ChooseCategoryViewController {
            let destinationView = segue.destination as! ChooseCategoryViewController
            destinationView.hero.modalAnimationType = .selectBy(presenting: .zoomSlide(direction: .left), dismissing: .zoomSlide(direction: .right))
        }
        
    }
    
    func cautionAlert() {
        let alertView = MessageView.viewFromNib(layout: .cardView)
        
        // Theme message elements with the warning style.
        alertView.configureTheme(.warning)
        
        // Add a drop shadow.
        alertView.bodyLabel?.textAlignment = .right
        
        alertView.configureDropShadow()
        
        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
        alertView.configureContent(title: nil, body: "اگه خارج بشی دیگه به این بازی دسترسی نداری", iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "خروج") { (UIButton) in
            SwiftMessages.hide()
            self.performSegue(withIdentifier: "backToModes", sender: nil)
        }
        
        // Increase the external margin around the card. In general, the effect of this setting
        // depends on how the given layout is constrained to the layout margins.
        alertView.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        // Reduce the corner radius (applicable to layouts featuring rounded corners).
        (alertView.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        
        // Show the message.
        SwiftMessages.show(view: alertView)
    }
    
}



