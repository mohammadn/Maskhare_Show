//
//  WordsModel.swift
//  pantomime
//
//  Created by mohammad najafzade on 5/14/19.
//  Copyright © 2019 mohammad najafzade. All rights reserved.
//

import Foundation

class WordsModel {
    
    func getWord() -> [Words] {
        var generatedWordsArray = [Words]()
        var wordsDic: [String:[String:[String]]]?
        
        // get data from file in local directory - start
        let path = Bundle.main.path(forResource: "WordsData", ofType: "txt")
        let url = URL(fileURLWithPath: path!)
        
        do {
            let data = try Data(contentsOf: url)
            let json = try JSONSerialization.jsonObject(with: data)

            wordsDic = json as? [String:[String:[String]]]
            
        }
        catch {
            print(error)
        }
        // end
        

        
        
        for (tag, points) in wordsDic! {
            for (point, name) in points {
                let words = Words()
                words.tag = tag
                words.point = point
                words.name = name
                generatedWordsArray.append(words)
            }
        }
        return generatedWordsArray
        
    }
    
}
