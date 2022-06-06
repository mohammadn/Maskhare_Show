//
//  ModesViewController.swift
//  DesignPantomime
//
//  Created by mohammad najafzade on 5/25/19.
//  Copyright © 2019 mohammad najafzade. All rights reserved.
//

import UIKit
import AMPopTip
import Hero

class ModesViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet var modesButtons: [UIButton]!
    @IBOutlet var modesInfoButtons: [UIButton]!
    
    var modesDetail = ["این حالت هیچ فرقی با پانتومیمی که خودمون همیشه تو خونه هامون با دوستامون یا اشناهامون بازی می کردیم نداره، بخاطر همین اسمش رو گذاشتیم کلاسیک.", "در این حالت انتخاب موضوع کلمه وجود نداره و تنها یک موضوع کلی موجود می باشد که داخل آن، کلمات از تمام دسته بندی ها وجود دارد، اگر تا حالا پانتومیم بازی نکردید پیشنهاد می کنیم که از این حالت شروع نکنید."]
    
    
    var popTipDidShow = false
    let popTip = PopTip()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Design View Controller
        
        // backButton style
        CALayer().addBorder([backButton], "#2A2B47FF", 3)
        CALayer().addBorderRadius([backButton], 15)
        UIButton().setBackgroundColor(view: [backButton], color: UIColor(hex: "#2A2B47FF")!, forState: .highlighted)
        
        // modesInfoButtons style
        CALayer().addBorder([modesInfoButtons[0]], "#DE343DFF", 5)
        CALayer().addBorderRadius(modesInfoButtons,20)
        CALayer().addMaskedCorners(modesInfoButtons, [.layerMinXMinYCorner, .layerMinXMaxYCorner])
        UIButton().setBackgroundColor(view: modesInfoButtons, color: UIColor(hex: "#DE343DFF")!, forState: .highlighted)
        
        // modesButtons style
        CALayer().addBorderRadius(modesButtons,20)
        CALayer().addMaskedCorners(modesButtons, [.layerMaxXMinYCorner, .layerMaxXMaxYCorner])
        modesButtons[0].clipsToBounds = true
        modesButtons[1].clipsToBounds = true
        
        // lock chegher
        modesButtons[0].isEnabled = false
        modesInfoButtons[1].isEnabled = false
        CALayer().addBorder([modesInfoButtons[1]], "#AAAAAAFF", 5)
        
        // MARK: PopTip Config
        popTip.shouldDismissOnTap = true
        popTip.bubbleColor = UIColor(hex: "#000000DD")!
        popTip.textColor = UIColor.white
        popTip.cornerRadius = 15
        popTip.padding = 30
        popTip.font = UIFont.systemFont(ofSize: 20)
        popTip.borderColor = UIColor.black
        popTip.borderWidth = 3
        popTip.appearHandler = { popTip in
            self.popTipDidShow = true
        };
        popTip.dismissHandler = { popTip in
            self.popTipDidShow = false
        }

    }
    
    // modesButton Click Action: go to NumberOfGroups page
    @IBAction func modesButtons(_ sender: AnyObject) {
        
        for i in 0...modesButtons.count-1 {
            if sender ===  modesButtons[i] {
                getVariables.selectedMode = modesButtons[i].titleLabel?.text
            }
        }
        performSegue(withIdentifier: "showNumberOfGroups", sender: nil)
        
    }
    
    // modesInfoButton Click Action: show PopTip description
    @IBAction func modesInfoButtons(_ sender: AnyObject) {
        
        for i in 0...modesInfoButtons.count-1 {
            if sender ===  modesInfoButtons[i] {
                if popTipDidShow == false {
                    popTip.show(text: modesDetail[i], direction: .none, maxWidth: 200, in: view, from: view.frame)
                } else {
                    popTip.hide()
                }
            }
        }
        
    }
    
    // config segues
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "backButton" {
            let destinationView = segue.destination as! ViewController
            destinationView.hero.modalAnimationType = .zoomSlide(direction: .right)
        }
        
    }
    
    
}
