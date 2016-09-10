//
//  QuestionsManager.swift
//  Tribz
//
//  Created by Алексей Соболевский on 04.09.16.
//  Copyright © 2016 Le poisson du Mars. All rights reserved.
//

import UIKit

class QuestionsManager: NSObject {
    static let sharedInstance = QuestionsManager()
    
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
//        Question(question: "Readjust the following shapes in descending order from the one you like most to the one you like the least.",
//            options: ["△", "⦚", "○", "☐"],
//            optionPoints: [0, 0, 0, 0],
//            colorSet: ColorSet.getColorSet(1)!)
    ]
    
    static func getQuestions() -> NSArray {
        return questions
    }
    
    static func getQuestionAtIndex(index: Int) -> Question? {
        guard index <= questions.count else {
            return nil
        }
        
        return questions[index]
    }
    
}
