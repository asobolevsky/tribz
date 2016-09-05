//
//  UserProgress.swift
//  Tribz
//
//  Created by Алексей Соболевский on 05.09.16.
//  Copyright © 2016 Le poisson du Mars. All rights reserved.
//

import UIKit

class UserProgress: NSObject {

    var redResult: Int
    var yellowResult: Int
    var greenResult: Int
    var blueResult: Int
    
    override init() {
        redResult = 0
        yellowResult = 0
        greenResult = 0
        blueResult = 0
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
    
}
