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
    
    private static let questions = [
        Question(question: defaultQuestion,
            options: ["Competitive", "Enthusiastic", "Patient", "Precise"],
            colorSet: ColorSet.getColorSet(0)!),
        Question(question: defaultQuestion,
            options: ["Assertive", "Sociable", "Peaceful", "Systematic"],
            colorSet: ColorSet.getColorSet(1)!),
        Question(question: defaultQuestion,
            options: ["Decisive", "Naturally expressive", "Empathetic", "Detail oriented"],
            colorSet: ColorSet.getColorSet(2)!),
        Question(question: defaultQuestion,
            options: ["Results-oriented", "Fun-loving", "Peacemaker", "Cautious"],
            colorSet: ColorSet.getColorSet(3)!),
        Question(question: defaultQuestion,
            options: ["I work and play hard", "I love surprises", "I often put my own needs last", "I prefer established rules and routines"],
            colorSet: ColorSet.getColorSet(0)!),
        Question(question: defaultQuestion,
            options: ["Fast", "Persuasive", "Supportive", "Organized"],
            colorSet: ColorSet.getColorSet(1)!),
        Question(question: defaultQuestion,
            options: ["Direct", "Cheerful", "Helping", "Questioning"],
            colorSet: ColorSet.getColorSet(2)!),
        Question(question: defaultQuestion,
            options: ["Sometimes I am so direct I upset people", "I can be too outgoing and not maintain my boundaries", "My desire to please others is sometimes so strong that I find it hard to say \"no\"", "I find it difficult to be flexible when last minute events disrupt my plans"],
            colorSet: ColorSet.getColorSet(3)!),
        Question(question: defaultQuestion,
            options: ["Winning is important to me", "Interacting with a lot of people energizes me", "I like to seek consensus, focussing on what can be agreed", "My natural inclination is to analyze things logically"],
            colorSet: ColorSet.getColorSet(0)!),
        Question(question: "Readjust the following shapes in descending order from the one you like most to the one you like the least.",
            options: ["△", "⦚", "○", "☐"],
            colorSet: ColorSet.getColorSet(1)!)
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
