//
//  Question.swift
//  Tribz
//
//  Created by Алексей Соболевский on 05.09.16.
//  Copyright © 2016 Le poisson du Mars. All rights reserved.
//

import UIKit

enum QuestionOptionsType {
    case text
    case image
}

class Question: NSObject {

    let question: String
    let options: [String]
    let optionPoints: [Int]
    let optionsType: QuestionOptionsType
    let colorSet: ColorSet
    
    convenience init(question: String, options: [String], optionPoints: [Int], colorSet: ColorSet) {
        self.init(question: question, options: options, optionsType: .text, optionPoints: optionPoints, colorSet: colorSet)
    }
    
    required init(question: String, options: [String], optionsType:QuestionOptionsType, optionPoints: [Int], colorSet: ColorSet) {
        self.question = question
        self.options = options
        self.optionPoints = optionPoints
        self.optionsType = optionsType
        self.colorSet = colorSet
    }
    
    
}
