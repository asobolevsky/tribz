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
    }
    
    func getPrimaryColor() -> PrimaryColor {
        let maxResult = max(redResult, yellowResult, greenResult, blueResult)
        
        if maxResult == redResult {
            return .Red
        } else if maxResult == yellowResult {
            return .Yellow
        } else if maxResult == greenResult {
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
