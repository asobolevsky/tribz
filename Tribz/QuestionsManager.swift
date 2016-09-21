//
//  QuestionsManager.swift
//  Tribz
//
//  Created by Алексей Соболевский on 04.09.16.
//  Copyright © 2016 Le poisson du Mars. All rights reserved.
//

import UIKit

enum UserInfoQuestionType: Int {
    case Gender
    case Age
    case Height
    case Weight
    case Sleep
    case InvalidType
}

class QuestionsManager: NSObject {
    static let sharedInstance = QuestionsManager()
    
    // options and points = [red, yellow, green, blue]
    
    private static let defaultQuestion = "HOW WELL DO THESE DESCRIBE YOU?"
    
    private static let defaultPoints = [4, 3, 2, 1]
    
    private static let questions = [
        Question(question: defaultQuestion,
            options: ["Competitive", "Enthusiastic", "Patient", "Precise"],
            optionPoints: defaultPoints,
            colorSet: ColorSet.getColorSet(0)!),
        Question(question: defaultQuestion,
            options: ["Assertive", "Sociable", "Peaceful", "Systematic"],
            optionPoints: defaultPoints,
            colorSet: ColorSet.getColorSet(1)!),
        Question(question: defaultQuestion,
            options: ["Decisive", "Naturally expressive", "Empathetic", "Detail oriented"],
            optionPoints: defaultPoints,
            colorSet: ColorSet.getColorSet(2)!),
        Question(question: defaultQuestion,
            options: ["Results-oriented", "Fun-loving", "Peacemaker", "Cautious"],
            optionPoints: defaultPoints,
            colorSet: ColorSet.getColorSet(3)!),
        Question(question: defaultQuestion,
            options: ["I work and play hard", "I love surprises", "I often put my own needs last", "I prefer established rules and routines"],
            optionPoints: defaultPoints,
            colorSet: ColorSet.getColorSet(0)!),
        Question(question: defaultQuestion,
            options: ["Fast", "Persuasive", "Supportive", "Organized"],
            optionPoints: defaultPoints,
            colorSet: ColorSet.getColorSet(1)!),
        Question(question: defaultQuestion,
            options: ["Direct", "Cheerful", "Helping", "Questioning"],
            optionPoints: defaultPoints,
            colorSet: ColorSet.getColorSet(2)!),
        Question(question: defaultQuestion,
            options: ["Sometimes I am so direct I upset people", "I can be too outgoing and not maintain my boundaries", "My desire to please others is sometimes so strong that I find it hard to say \"no\"", "I find it difficult to be flexible when last minute events disrupt my plans"],
            optionPoints: defaultPoints,
            colorSet: ColorSet.getColorSet(3)!),
        Question(question: defaultQuestion,
            options: ["Winning is important to me", "Interacting with a lot of people energizes me", "I like to seek consensus, focussing on what can be agreed", "My natural inclination is to analyze things logically"],
            optionPoints: defaultPoints,
            colorSet: ColorSet.getColorSet(0)!),
        Question(question: "Readjust the following shapes in descending order from the one you like most to the one you like the least.",
            options: ["triangle", "blot", "circle", "square"],
            optionsType: .Image,
            optionPoints: defaultPoints,
            colorSet: ColorSet.getColorSet(1)!)
    ]
    
    // correlates with UserInfoQuestionTypes enum
    private static let userInfoQuestions = [
        Question(question: "Are you male or female?",
            options: ["male", "female"],
            optionsType: .Image,
            optionPoints: [],
            colorSet: ColorSet.getColorSet(0)!),
        Question(question: "Your age",
            options: ["Under 25", "25-39", "40-55", "Over 55"],
            optionPoints: [],
            colorSet: ColorSet.getColorSet(0)!),
        Question(question: "Your height (m)",
            options: ["Under 1.55", "1.55-1.65", "1.66-1.75", "Over 1.75"],
            optionPoints: [],
            colorSet: ColorSet.getColorSet(1)!),
        Question(question: "Your weight (kg)",
            options: ["Under 60", "60-70", "71-80", "Over 80"],
            optionPoints: [],
            colorSet: ColorSet.getColorSet(1)!),
        Question(question: "Sleeping position",
            options: ["On my back", "On my belly", "On my side"],
            optionPoints: [],
            colorSet: ColorSet.getColorSet(2)!)
    ]

    
    private static var randomizedQuestions: [Question]? = nil
    
    static func getQuestions() -> [Question] {
        
        if let randomizedQuestions = randomizedQuestions {
            return randomizedQuestions
        }
        
        randomizedQuestions = questions.shuffle()
        
        return randomizedQuestions!
    }
    
    static func getQuestionAtIndex(index: Int) -> Question? {
        guard index <= getQuestions().count else {
            return nil
        }
        
        return getQuestions()[index]
    }
    
    static func getUserInfoQuestions() -> [Question] {
        return userInfoQuestions
    }
    
    static func getUserInfoQuestionAtIndex(index: Int) -> Question? {
        guard index <= userInfoQuestions.count else {
            return nil
        }
        
        return userInfoQuestions[index]
    }
    
}

extension CollectionType {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}
