//
//  Question.swift
//  Tribz
//
//  Created by Алексей Соболевский on 05.09.16.
//  Copyright © 2016 Le poisson du Mars. All rights reserved.
//

import UIKit

class Question: NSObject {

    let question: String
    let options: NSArray
    
    let colorSet: ColorSet
    
    required init(question: String, options: NSArray, colorSet: ColorSet) {
        self.question = question
        self.options = options
        self.colorSet = colorSet
    }
    
    
}
