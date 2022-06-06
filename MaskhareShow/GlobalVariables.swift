//
//  File.swift
//  DesignPantomime
//
//  Created by mohammad najafzade on 5/28/19.
//  Copyright © 2019 mohammad najafzade. All rights reserved.
//

import Foundation
import UIKit

class GlobalVariables {
    
    var selectedMode: String?
    var numberOfGroups = 0
    var groupButtons = [UIButton]()
    var numberOfRounds = 3
    var selectedNames = [[String]]()
    var selectedGroupsName = [String]()
    var wordsArray: [Words]?
    var scoreBoardStatus = false
    var scoreBoardStatusGaurdian = false
    var scoreLabels = [[UILabel]]()
    var nextLabel: UILabel!
    var sumLabel: UILabel!
    var groupTurn: String?
    var playerTurn: String?
    var easterEgg: Int
    var selectedWord: String?
    var pointOfWord = 0
    var pickedCategory = [String:[String:[Int]]]()
    

    
    init( selectedMode: String, numberOfGroups: Int, groupButtons: [UIButton], numberOfRounds: Int, selectedNames:[[String]], selectedGroupsName: [String], wordsArray: [Words], scoreBoardStatus: Bool, scoreBoardStatusGaurdian: Bool, scoreLabels: [[UILabel]], nextLabel: UILabel, sumLabel: UILabel, groupTurn: String, playerTurn: String, easterEgg: Int, selectedWord: String, pointOfWord: Int, pickedCategory: [String:[String:[Int]]]) {
        self.selectedMode = selectedMode
        self.selectedNames = selectedNames
        self.numberOfGroups = numberOfGroups
        self.groupButtons = groupButtons
        self.numberOfRounds = numberOfRounds
        self.selectedGroupsName = selectedGroupsName
        self.wordsArray = wordsArray
        self.scoreBoardStatus = scoreBoardStatus
        self.scoreBoardStatusGaurdian = scoreBoardStatusGaurdian
        self.scoreLabels = scoreLabels
        self.nextLabel = nextLabel
        self.sumLabel = sumLabel
        self.groupTurn = groupTurn
        self.playerTurn = playerTurn
        self.easterEgg = easterEgg
        self.selectedWord = selectedWord
        self.pointOfWord = pointOfWord
        self.pickedCategory = pickedCategory
    }
    
}
var getVariables = GlobalVariables( selectedMode: "", numberOfGroups: 0, groupButtons: [], numberOfRounds: 3, selectedNames: Array(repeating: Array(repeating: "", count: 0), count: 0), selectedGroupsName: [], wordsArray: [], scoreBoardStatus: false, scoreBoardStatusGaurdian: false, scoreLabels: [], nextLabel: UILabel(), sumLabel: UILabel(), groupTurn: "", playerTurn: "", easterEgg: 0, selectedWord: "", pointOfWord: 0, pickedCategory: [:])

