//
//  ShowWordViewController.swift
//  DesignPantomime
//
//  Created by mohammad najafzade on 5/29/19.
//  Copyright © 2019 mohammad najafzade. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class ShowWordViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var showButton: UIButton!
    @IBOutlet var toolbarButtons: [UIButton]!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var preparingTimerLabel: UILabel!
    @IBOutlet weak var playerTurn: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var showWordStackViewConstraint: NSLayoutConstraint!
    
    var toolbarButtonStatus = [false, false, false]
    var startButtonStatus = false
    var showWordStatus = false
    var preparingCounterTimer = Timer()
    var gameCounterTimer = Timer()
    var preparingCounter = 14
    var gameCounter = 0
    var wordChanged = 0
    var tickTock: AVAudioPlayer?
    var beep: AVAudioPlayer?
    var beepCondition = true
    var bellRing: AVAudioPlayer?
    var generatedWord = ""
    
    var startGameTimer = Timer()
    var ShowHideWordTimer = Timer()
    var showHideWordButtonTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //prevent from sleeping
        UIApplication.shared.isIdleTimerDisabled = true
//        // exact
//        print("exactly the same :")
//        var duplicateWords = [String]()
//        for index in 0...getVariables.wordsArray!.count-1 {
//
//            for item in 0...getVariables.wordsArray![index].name.count-1 {
//
//                for itemin in 0...getVariables.wordsArray![index].name.count-1 {
//
//                    if getVariables.wordsArray![index].name[item] == getVariables.wordsArray![index].name[itemin] && itemin != item {
//
//                        if duplicateWords.count == 0 {
//                            duplicateWords.append(getVariables.wordsArray![index].name[item])
//                        } else {
//                            for itemon in 0...duplicateWords.count-1 {
//
//                                if duplicateWords[itemon] == getVariables.wordsArray![index].name[item] {
//                                    break
//                                } else if itemon == duplicateWords.count-1 {
//
//                                    duplicateWords.append(getVariables.wordsArray![index].name[item])
//
//                                }
//                            }
//                        }
//                    }
//
//                }
//
//            }
//        }
//        print(duplicateWords)
        // semi
//        print("maybe there is a duplicate")
//        for index in 0...getVariables.wordsArray!.count-1 {
//
//            for item in 0...getVariables.wordsArray![index].name.count-1 {
//
//                for itemin in 0...getVariables.wordsArray![index].name.count-1 {
//                    if getVariables.wordsArray![index].name[item].contains(getVariables.wordsArray![index].name[itemin].prefix(3)) && itemin != item {
//                        print("")
//                        print(getVariables.wordsArray![index].name[item])
//                        print(getVariables.wordsArray![index].name[itemin])
//                        print("")
//                    }
//
//
//                }
//
//            }
//        }
        
        // same word
//        print("same word in all")
//        for index in 0...getVariables.wordsArray!.count-1 {
//            
//            for item in 0...getVariables.wordsArray![index].name.count-1 {
//                print("")
//                var a = 0
//                for itemin in 0...getVariables.wordsArray![index].name.count-1 {
//                    if getVariables.wordsArray![index].name[item].contains(getVariables.wordsArray![index].name[itemin].components(separatedBy: .whitespaces)[0]) && itemin != item {
//                        if a == 0 {
//                            print(getVariables.wordsArray![index].name[item])
//                            a = 1
//                        }
//                        print(getVariables.wordsArray![index].name[itemin])
//                        
//                    }
//                    
//                    
//                }
//                print("")
//            }
//        }

        // MARK: Design View Controller
        
        // 1. toolbarButton and showButton and startButton
        CALayer().addBorder([toolbarButtons[0], toolbarButtons[1], toolbarButtons[2]], "#2A2B47FF", 3)
        CALayer().addBorderRadius([showButton, toolbarButtons[0], toolbarButtons[2], startButton], 15)
        CALayer().addMaskedCorners([showButton], [.layerMinXMinYCorner, .layerMaxXMinYCorner])
        CALayer().addMaskedCorners([toolbarButtons[0]], [.layerMinXMaxYCorner])
        CALayer().addMaskedCorners([toolbarButtons[2]], [.layerMaxXMaxYCorner])
        toolbarButtons[2].clipsToBounds = true
        startButton.clipsToBounds = true
        toolbarButtons[0].isEnabled = false
        toolbarButtons[2].isEnabled = false
        UIButton().setBackgroundColor(view: [startButton], color: UIColor(hex: "#9B9B9BFF")!, forState: .normal)
        
        // 2. set clock
        if getVariables.pointOfWord == 4{
            timerLabel.text = "01:45"
            gameCounter = 104
        } else if getVariables.pointOfWord == 2{
            timerLabel.text = "01:30"
            gameCounter = 89
        } else if getVariables.pointOfWord == 7{
            timerLabel.text = "03:00"
            gameCounter = 179
        } else if getVariables.pointOfWord == 5{
            timerLabel.text = "02:30"
            gameCounter = 149
        } else {
            timerLabel.text = "02:00"
            gameCounter = 119
        }
        // 3. config player turn
        playerTurn.text = "\(getVariables.playerTurn!) در حال اجرای \(getVariables.selectedWord!)"
        
        // 4. startButton
        startButton.isEnabled = false
        preparingTimerLabel.isHidden = true
        
        
        // config sound
        let tickTockUrl = Bundle.main.url(forResource: "tickTock", withExtension: "wav")
        let beepUrl = Bundle.main.url(forResource: "beep", withExtension: "wav")
        let bellRingUrl = Bundle.main.url(forResource: "bellRing", withExtension: "wav")
        
        do {
            tickTock = try AVAudioPlayer(contentsOf: tickTockUrl!)
            beep = try AVAudioPlayer(contentsOf: beepUrl!)
            bellRing = try AVAudioPlayer(contentsOf: bellRingUrl!)
        } catch {
            // couldn't load file :(
        }
        
    }
    @IBAction func backButton(_ sender: Any) {
    }
    @IBAction func showWord(_ sender: Any) {
        
        generateWordForShow()
        showWordConfig()
        
    }
    @IBAction func changeWord(_ sender: Any) {
        
        if toolbarButtonStatus[0] == false {
            generateWordForShow()
            preparingCounter = 15
            toolbarButtonStatus[0] = !toolbarButtonStatus[0]
            wordChanged = 1
            toolbarButtons[0].isEnabled = false
            toolbarButtons[0].setImage(UIImage(named: "disableChange"), for: .normal)
            
        }
        
    }
    @IBAction func showHideWord(_ sender: Any) {
        
        if toolbarButtonStatus[1] == false {
            
            if showWordStatus == false {
                generateWordForShow()
                showWordConfig()
            } else {
                toolbarButtonStatus[1] = !toolbarButtonStatus[1]
                UIButton().setBackgroundColor(view: [toolbarButtons[1]], color: UIColor(hex: "#2A2B47FF")!, forState: .normal)
                toolbarButtons[1].setImage(UIImage(named: "hide"), for: .normal)
                self.showButton.setTitle(generatedWord, for: .normal)
                
                showHideWordButtonTimer.invalidate()
                showHideWordButtonTimer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(showHideWordButtonTimerAction), userInfo: nil, repeats: false)
            }
            
        } else {
            
            self.showButton.setTitle("پانتومیمه", for: .normal)
            showHideWordButtonTimer.invalidate()
            toolbarButtonStatus[1] = !toolbarButtonStatus[1]
            UIButton().setBackgroundColor(view: [toolbarButtons[1]], color: UIColor(hex: "#EED9CBFF")!, forState: .normal)
            toolbarButtons[1].setImage(UIImage(named: "show"), for: .normal)
            
        }
        
    }
    @IBAction func muteSound(_ sender: Any) {
        
        if toolbarButtonStatus[2] == false {
            
            toolbarButtonStatus[2] = !toolbarButtonStatus[2]
            UIButton().setBackgroundColor(view: [toolbarButtons[2]], color: UIColor(hex: "#2A2B47FF")!, forState: .normal)
            toolbarButtons[2].setImage(UIImage(named: "muted"), for: .normal)
            tickTock!.stop()
            beepCondition = false
            
        } else {
            
            toolbarButtonStatus[2] = !toolbarButtonStatus[2]
            UIButton().setBackgroundColor(view: [toolbarButtons[2]], color: UIColor(hex: "#EED9CBFF")!, forState: .normal)
            toolbarButtons[2].setImage(UIImage(named: "notMuted"), for: .normal)
            tickTock!.play()
            beepCondition = true
            
        }
        
    }
    
    @IBAction func startGame() {
        
        if startButtonStatus == false {
            
            addToPickedCategory()
            preparingTimerLabel.isHidden = true
            preparingCounterTimer.invalidate()
            startGameTimer.invalidate()
            startButtonStatus = true
            toolbarButtons[2].isEnabled = true
            toolbarButtons[0].isEnabled = false
            toolbarButtonStatus[0] = !toolbarButtonStatus[0]
            startButton.setTitle("اتمام بازی", for: .normal)
            UIButton().setBackgroundColor(view: [startButton], color: UIColor(hex: "#DE343DFF")!, forState: .normal)
            tickTock?.play()
            tickTock?.numberOfLoops = -1

            gameCounterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateGameCounter), userInfo: nil, repeats: true)
            
        } else {
            
            gameCounterTimer.invalidate()
            performSegue(withIdentifier: "showGuessingStatus", sender: nil)
            tickTock?.stop()
            
        }
        
    }
    
    @objc func updatePreparingCounter() {
        
        if preparingCounter >= 0 {
            
            let minutes = preparingCounter/60
            let seconds = preparingCounter%60
            
            if 0 <= seconds && seconds < 10 {
                preparingTimerLabel.text = "0\(minutes) : 0\(seconds)"
            } else {
                preparingTimerLabel.text = "0\(minutes) : \(seconds)"
            }
            
            preparingCounter -= 1
            
            if preparingCounter < 2 && beepCondition {

                beep?.play()
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))

            }
            
        } else {
            
            preparingCounterTimer.invalidate()
            beep?.stop()
            
        }
        
    }
    
    @objc func updateGameCounter() {
        
        if gameCounter > 0 {
            
            let minutes = gameCounter/60
            let seconds = gameCounter%60
            
            if 0 <= seconds && seconds < 10 {
                timerLabel.text = "0\(minutes) : 0\(seconds)"
            } else {
                timerLabel.text = "0\(minutes) : \(seconds)"
            }
            
            gameCounter -= 1
            
            if gameCounter < 5 && beepCondition {
                
                beep?.play()
                AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            }
            
        } else {
            
            gameCounterTimer.invalidate()
            beep?.stop()
            tickTock?.stop()
            bellRing?.play()
            performSegue(withIdentifier: "showGuessingStatus", sender: nil)
            
        }
        
    }
    
    //config timers
    @objc func startGameTimerAction() {
        startGame()
    }
    
    @objc func ShowHideWordTimerAction() {
        showButton.setTitle("پانتومیمه", for: .normal)
        showButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        toolbarButtonStatus[1] = !self.toolbarButtonStatus[1]
        UIButton().setBackgroundColor(view: [self.toolbarButtons[1]], color: UIColor(hex: "#EED9CBFF")!, forState: .normal)
        toolbarButtons[1].setImage(UIImage(named: "show"), for: .normal)
    }
    
    @objc func showHideWordButtonTimerAction() {
        showButton.setTitle("پانتومیمه", for: .normal)
        showButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        toolbarButtonStatus[1] = !self.toolbarButtonStatus[1]
        UIButton().setBackgroundColor(view: [self.toolbarButtons[1]], color: UIColor(hex: "#EED9CBFF")!, forState: .normal)
        toolbarButtons[1].setImage(UIImage(named: "show"), for: .normal)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is ChooseCategoryViewController {
            
            let destinationView = segue.destination as! ChooseCategoryViewController
            destinationView.hero.modalAnimationType = .slide(direction: .down)
        }
        
        if segue.destination is GuessingStatusViewController {
            
            let destinationView = segue.destination as! GuessingStatusViewController
            destinationView.gameCounterPoint = gameCounter/30
            destinationView.wordChanged = wordChanged
            
        }
    }

    func showWordConfig() {
        
        showWordStatus = true
        showButton.isEnabled = false
        
        toolbarButtons[0].isEnabled = true
        toolbarButtons[0].setImage(UIImage(named: "change"), for: .normal)
        
        toolbarButtons[1].setImage(UIImage(named: "hide"), for: .normal)
        toolbarButtonStatus[1] = !toolbarButtonStatus[1]
        UIButton().setBackgroundColor(view: [toolbarButtons[1]], color: UIColor(hex: "#2A2B47FF")!, forState: .normal)
        
        startButton.isEnabled = true
        startButton.setBackgroundColor(view: [startButton], color: UIColor(hex: "#FFA000FF")!, forState: .normal)
        
        backButton.isEnabled = false
        UIView.animate(withDuration: 0.4) {
            self.backButton.removeFromSuperview()
            self.showWordStackViewConstraint.constant = 40
            self.view.layoutIfNeeded()
        }
        
        preparingTimerLabel.isHidden = false
        preparingCounterTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updatePreparingCounter), userInfo: nil, repeats: true)
    }
    
    
    func generateWordForShow() {
        
        for index in getVariables.wordsArray! {
            if index.tag == getVariables.selectedWord && index.point == String(getVariables.pointOfWord)  {
                
                if index.name.count != 0 {
                    let randomNumber = Int(arc4random_uniform(UInt32(index.name.count)))
                    
                    if getVariables.selectedWord == "ضرب المثل" {
                        showButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
                        showButton.titleLabel?.numberOfLines = 0;
                        
                    }
                    showButton.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping;
                    showButton.titleLabel?.textAlignment = NSTextAlignment.center
                    
                    showButton.setTitle(index.name[randomNumber], for: .normal)
                    generatedWord = index.name[randomNumber]
                    index.name.remove(at: randomNumber)
                    
                }
                
                break
            }
        }
        
        startGameTimer.invalidate()
        ShowHideWordTimer.invalidate()
        startGameTimer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(startGameTimerAction), userInfo: nil, repeats: false)
        ShowHideWordTimer = Timer.scheduledTimer(timeInterval: 20, target: self, selector: #selector(ShowHideWordTimerAction), userInfo: nil, repeats: false)
        
    }
    
    func addToPickedCategory() {
        
        var tempArray = getVariables.pickedCategory[getVariables.groupTurn!]
        
        if tempArray!.isEmpty {
            tempArray![getVariables.selectedWord!] = [getVariables.pointOfWord]
            
        } else {
            
            for (key,_) in tempArray! {
                
                if key == getVariables.selectedWord! {
                    tempArray![key]!.append(getVariables.pointOfWord)
                    break
                } else if key == Array(tempArray!.keys).last {
                    tempArray![getVariables.selectedWord!] = [getVariables.pointOfWord]
                    break
                }
        
            }
            
        }
        
        getVariables.pickedCategory[getVariables.groupTurn!] = tempArray
        
    }
    
}
