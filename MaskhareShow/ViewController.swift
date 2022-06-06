//
//  ViewController.swift
//  DesignPantomime
//
//  Created by mohammad najafzade on 5/25/19.
//  Copyright © 2019 mohammad najafzade. All rights reserved.
//

import UIKit
import SwiftMessages
import MessageUI
import LRSpotlight

public protocol SpotlightDelegate: class {
    func didAdvance(to: Int, of total: Int)
    func didDismiss()
}

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var topView: UIView!
    @IBOutlet var topButtons: [UIButton]!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var logoLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: Design View Controller
        CALayer().addBorderRadius(topButtons, 15)
        CALayer().addBorderRadius([logoLabel, playButton, bottomView], 15)
        CALayer().addMaskedCorners([playButton, bottomView], [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        CALayer().addMaskedCorners([logoLabel], [.layerMinXMaxYCorner, .layerMaxXMaxYCorner])
        
        // topView
//        topView.addBottomRoundedEdge(desiredCurve: 3)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let temp = isAppAlreadyLaunchedOnce()
        if !temp {
            startIntro()
        }
        
    }
    
    func startIntro() {
        let nodes = [SpotlightNode(text: "برای شروع بازی اینجا باید کلیک کنی", target: .view(playButton)),
                     SpotlightNode(text: "اگه دفعه اول که این بازی رو انجام میدی حتما قبلش قوانینمون رو مطالعه کن", target: .view(topButtons[0])),
                     SpotlightNode(text: "خوشحال میشیم دوستات رو هم دعوت کنی تا دور هم پانتومیم بزنیم", target: .view(topButtons[1])),
                     SpotlightNode(text: "اگه سوالی داشتی و یا می خواستی که با ما بیشتر آشنا بشی می تونی ما رو تو شبکه های اجتماعی دنبال کنی", target: .view(bottomView))]
        
        Spotlight.delay = 60.0
        Spotlight.backButtonTitle = "قبلی"
        Spotlight.nextButtonTitle = "بعدی"
        Spotlight().startIntro(from: self, withNodes: nodes)
    }

    
    @IBAction func inviteFriends(_ sender: Any) {
        let firstActivityItem = "سلام بازی باحالیه اگه خواستی نصبش کن"
        let secondActivityItem : NSURL = NSURL(string: "https://t.me/maskhareshow")!
        
        let activityViewController : UIActivityViewController = UIActivityViewController(
            activityItems: [firstActivityItem, secondActivityItem], applicationActivities: nil)
        
        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
//        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    @IBAction func telegram(_ sender: Any) {
        UIApplication.shared.open(NSURL(string: "https://t.me/maskhareshow")! as URL, options: [:], completionHandler: nil)
    }
    @IBAction func email(_ sender: Any) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self as MFMailComposeViewControllerDelegate
            mail.setToRecipients(["maskhareshow@gmail.com"])
            mail.setSubject("دمتون گرم")
            mail.setMessageBody("<p>شماها خیلی باحالید</p><br/><p>با فرستادن متن بالا یکم بهمون امید بدید :)</p>", isHTML: true)
            
            present(mail, animated: true)
        } else {
            // show failure alert
        }
    }
    
    // show next page with zoomslide animation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "nextPage" {
            let destinationView = segue.destination as! ModesViewController
            destinationView.hero.modalAnimationType = .selectBy(presenting: .zoomSlide(direction: .left), dismissing: .zoomSlide(direction: .right))
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

    func isAppAlreadyLaunchedOnce()->Bool{
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched")
            return true
        }else{
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
    
//    func firstTimeAlert() {
//        let alertView = MessageView.viewFromNib(layout: .centeredView)
//
//        var config = SwiftMessages.Config()
//        // Theme message elements with the warning style.
//        alertView.configureTheme(.success)
//
//        // Add a drop shadow.
//        alertView.bodyLabel?.textAlignment = .center
//
//        alertView.configureDropShadow()
//
//        // Set message title, body, and icon. Here, we're overriding the default warning
//        // image with an emoji character.
//        alertView.configureContent(title: nil, body: "اولین بار داری پانتومیم ما رو بازی می کنی؟ میخوای قبلش قوانینمون رو بدونی؟", iconImage: nil, iconText: nil, buttonImage: nil, buttonTitle: "قوانین") { (UIButton) in
//            SwiftMessages.hide()
//            self.performSegue(withIdentifier: "rules", sender: nil)
//        }
//
//        // style
//        alertView.bodyLabel?.font = UIFont.systemFont(ofSize: 20)
//        alertView.button?.titleLabel?.font = UIFont.systemFont(ofSize: 30)
//
//        // Increase the external margin around the card. In general, the effect of this setting
//        // depends on how the given layout is constrained to the layout margins.
//        alertView.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
//
//        // Reduce the corner radius (applicable to layouts featuring rounded corners).
//        (alertView.backgroundView as? CornerRoundingView)?.cornerRadius = 10
//
//        // config
//        config.presentationStyle = .center
//        config.duration = .forever
//        config.dimMode = .gray(interactive: true)
//
//        // Show the message.
//        SwiftMessages.show(config: config, view: alertView)
//    }
    
}

