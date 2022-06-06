//
//  ChooseGroupNameViewController.swift
//  DesignPantomime
//
//  Created by mohammad najafzade on 5/28/19.
//  Copyright © 2019 mohammad najafzade. All rights reserved.
//

import UIKit

class ChooseGroupNameViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var groupNamesPickerView: UIPickerView!
    
    var groupsName = [String]()
    var selectedGroup = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.groupNamesPickerView.delegate = self
        self.groupNamesPickerView.dataSource = self
        
        for n in 0...groupsName.count-1 {
            if getVariables.selectedGroupsName[selectedGroup] == groupsName[n] {
                groupNamesPickerView.selectRow(n, inComponent: 0, animated: true)
            }
        }
        
    }
    
    // number of Column in pickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
        
    }
    
    // number of rows in pickerView
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return groupsName.count
        
    }
    
    // selected row in pickerView
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        
        getVariables.selectedGroupsName[selectedGroup] = groupsName[row]
        getVariables.groupButtons[selectedGroup].setTitle(groupsName[row], for: .normal)
        print(getVariables.selectedGroupsName)
        
    }
    
    // title for each row in pickerView
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return groupsName[row]
        
    }
    
    // change attribute of each title like textColor
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributedString = NSAttributedString(string: groupsName[row], attributes: [NSAttributedString.Key.foregroundColor : UIColor(hex: "#EFEFEFFF")!])
        return attributedString
    }

}
