//
//  UserProgress.swift
//  Tribz
//
//  Created by Алексей Соболевский on 05.09.16.
//  Copyright © 2016 Le poisson du Mars. All rights reserved.
//

import UIKit

class UserProgress: NSObject {
    
    var questionsResult: [[Int]]
    var sortedResults: [Int]?
    var colorsPreference: [PrimaryColor]

    var redResult: Int {
        var res = 0
        
        for points in questionsResult {
            res += points[0]
        }
        
        return res
    }
    
    var yellowResult: Int {
        var res = 0
        
        for points in questionsResult {
            res += points[1]
        }
        
        return res
    }
    
    var greenResult: Int {
        var res = 0
        
        for points in questionsResult {
            res += points[2]
        }
        
        return res
    }
    
    var blueResult: Int {
        var res = 0
        
        for points in questionsResult {
            res += points[3]
        }
        
        return res
    }
    
    override init() {
        questionsResult = []
        colorsPreference = []
    }
    
    func getSortedResults() -> [Int] {
        if let results = sortedResults {
            return results
        }
        
        sortedResults = [redResult, yellowResult, greenResult, blueResult].sort(>)
        return sortedResults!
    }
    
    func getPrimaryColor() -> PrimaryColor {
        let result = getSortedResults()[0]
        return getColorForResult(result)    }
    
    func getSecondaryColor() -> PrimaryColor {
        let result = getSortedResults()[1]
        return getColorForResult(result)    }
    
    func getRecessiveColor() -> PrimaryColor {
        let result = getSortedResults()[2]
        return getColorForResult(result)
    }
    
    func getOppositeColor() -> PrimaryColor {
        let result = getSortedResults()[3]
        return getColorForResult(result)
    }
    
    func getColorForResult(result: Int) -> PrimaryColor {
        if result == redResult && !colorsPreference.contains(.Red) {
            return .Red
        } else if result == yellowResult && !colorsPreference.contains(.Yellow) {
            return .Yellow
        } else if result == greenResult && !colorsPreference.contains(.Green) {
            return .Green
        } else {
            return .Blue
        }
    }
    
    func calculatePointsTotal() -> Int {
        return redResult + yellowResult + greenResult + blueResult
    }
    
    func getColorsPercentage() -> NSArray {
        let percentageArray = NSMutableArray()
        
        let pointsTotal = calculatePointsTotal()
        
        let redPercent = (redResult * 100) / pointsTotal
        percentageArray[0] = redPercent
        
        let yellowPercent = (yellowResult * 100) / pointsTotal
        percentageArray[1] = yellowPercent
        
        let greenPercent = (greenResult * 100) / pointsTotal
        percentageArray[2] = greenPercent
        
        let bluePercent = 100 - redPercent - yellowPercent - greenPercent
        percentageArray[3] = bluePercent
        
        return percentageArray
    }
    
}

extension Array {
    func contains<T where T : Equatable>(obj: T) -> Bool {
        return self.filter({$0 as? T == obj}).count > 0
    }
}
