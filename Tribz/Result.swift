//
//  Result.swift
//  Tribz
//
//  Created by Алексей Соболевский on 05.09.16.
//  Copyright © 2016 Le poisson du Mars. All rights reserved.
//

import UIKit

class Result: NSObject {
    
    fileprivate static let results: [PrimaryColor: [String]] = [
        .Red: ["Red light has a wavelength of about 650 nanometers.\nRed is the color of fire and blood, so it is associated with energy, war, danger, strength, power and determination.\nRed enhances human metabolism, increases respiration rate, and raises blood pressure.\nStop signs, stoplights, red cross, Ferraris, the first chakra and fire equipment are red.\nIt is a color found in many national flags.\nHaving high red energy you tend to behave...\n...as strong leader, fast paced thinker, risk taker, purposeful, critical thinker, driving, strong-willed, less patient, extroverted, competitive, problem solver, direct, outspoken and rational.\nYour focus is on results. You have a strong determination that influences those you interact with and you approach others in a direct and straightforward manner.\nYou enjoy applying your logical mind rigorously to work issues. Achieving a successful outcome supersedes people's feelings.\nYou can really enjoy a good, well thought through argument. You embrace conflict, as it clears the air and allows space to express concerns. You will argue your position forcefully and will not easily concede ground. You may appear aggressive and antagonistic especially to people with high green energy.\n\n" +
            "\t• You take great pleasure in working passionately and purposefully towards your goals.\n" +
            "\t• You to set yourself very ambitious targets and have high standards.\n" +
            "\t• Finishing the job and achieving your goals are very important to you.\n" +
            "\t• You tell things as you see them.\n" +
            "\t• Winning is important to you.\n" +
            "\t• You have a high opinion of your own abilities.\n" +
            "\t• You work well in a group, where you quickly move to take control to mobilize resources and achieve results.\n" +
            "\t• Your biggest fear is losing control.\n" +
            "\t• Time is of essence and you can compromise in quality in order to deliver on time.",
            
            "Communicating with a person with high red energy don’t:\n\n" +
            "\t• Be vague or ramble on\n\tWaffle or hesitate\n" +
            "\t• Become personal waste their time\n" +
            "\t• Ask irrelevant questions\n" +
            "\t• Try to take control",
            
            "Communicating with a person with high red energy do:\n\n" +
            "\t• Get to business quickly,\n" +
            "\t• Be succinct and precise\n" +
            "\t• Give them facts and few details focus on results and outcomes\n" +
            "\t• Speak and act confident and direct"],
        
        .Yellow: ["Yellow light has a wavelength of about 570 nanometers.\nIt is the color of sunshine associated with joy, happiness, optimism and partying: think of the smiley.\nIt is the color of the third chakra.\nYellow is an attention getter: think of taxicabs and of the classic color of Stabilo Boss highlighter.\n" +
            "Having high yellow energy you tend to behave...\n" +
            "...as fun, convincing, engaging, sociable, talkative, expressive, extroverted, feeling, the soul of the party, imaginative, visionary, cheerful, influencing and enthusiastic.\n\n" +
            "\t• You act very informal, very optimistic and impulsive.\n" +
            "\t• Your enthusiasm is contagious.\n" +
            "\t• You are a fast paced thinker and spontaneous.\n" +
            "\t• You tend to decide instinctively, without the need of gathering lots of details.\n" +
            "\t• You fight routines and get bored quickly.\n" +
            "\t• You enjoy and seek the company of others and like being noticed and appreciated.\n" +
            "\t• You make new friends very easily.\n" +
            "\t• You are persuasive and a source of inspiration.\n" +
            "\t• You tend to dominate the conversation. You enjoy and find natural interacting and mingling with strangers and new people.\n" +
            "\t• When it is not possible a vis-a-vis you enjoy and use the phone a lot to converse, discuss, chat, brainstorm with your connections.\n" +
            "\t• You think out loud and tend to finishing other people’s sentences.\n" +
            "\t• You like having options and flexibility and think in big pictures. You enjoy working in an easygoing and unstructured way.\n" +
            "\t• You have a strong imagination and are a vulcan of ideas, you focus on solutions and possibilities.\n" +
            "\t• You enjoy working in a team, where you will quickly try to be the center of attention.\n" +
            "\t• You fight the status quo and embrace and stimulate change.\n" +
            "\t• You tend to wait to the last minute to complete tasks and projects and tend to run out of time.\n" +
            "\t• Your biggest fear is losing prestige and acknowledgment.",
            
            "Communicating with a person with high yellow energy don’t:\n\n" +
            "\t• Burden them down with routine and bureaucracy" +
            "\t• Get into details\n" +
            "\t• Put them to work alone\n" +
            "\t• Be impersonal\n" +
            "\t• Jump right into business issues without taking time to bond first\n" +
            "\t• Act aloof or detached",
            
            "Communicating with a person with high yellow energy do:\n\n" +
            "\t• Be friendly and sociable before mentioning any business" +
            "\t• Talk about options, big pictures and other people\n" +
            "\t• Be open and flexible enthusiastic and energetic\n" +
            "\t• Be fast paced in delivering your ideas\n" +
            "\t• Use humour entertaining and engaging\n" +
            "\t• Appreciate and acknowledge them for their ideas, efforts and input"],
        
        .Green: ["Green light has a wavelength of about 500 nanometers.\nGreen is the color of nature: trees, meadows, forests. It is the color of the fourth chakra (heart chakra). It symbolizes endurance, harmony, care, and stability.\nIt is the most restful color for the human eye. It is the color of free passage in traffic-lights: it symbolizes safety.\n\n" +
            "Having high green energy you tend to behave...\n" +
            "...as laid back, relaxed, patient, reliable, accommodating, feeling, introverted, calm, easy to get along with, focused on relationships, courteous and considerate of people, amenable, caring and reflective.\n\n" +
            "\t• You are informal in your approach.\n" +
            "\t• You are a slower paced thinker.\n" +
            "\t• You are understanding and democratic, therefore you work well one to one and in groups.\n" +
            "\t• You are humble for yourself but well versed in acknowledging the efforts, inputs and achievements of other people.\n" +
            "\t• You are compassionate and fully aware and considering the needs of others with empathy.\n" +
            "\t• You seek harmony, depth in relationships and peace. You defend what you value with determination and persistence.\n" +
            "\t• You do not enjoy conflicts and therefore act as facilitator and pacificator in case of conflicting. Better, you work systematically to prevent potential conflicts through diplomacy\n" +
            "\t• You value people over processes and results.\n" +
            "\t• You make sure all individual perspectives are carefully heard and considered in making choices or decisions. You provide support and listening to people.\n" +
            "\t• Your leadership style is quiet and gentle.\n" +
            "\t• You might say “yes” when in fact is a “no” to maintain peace and to not disappoint.\n" +
            "\t• You don't enjoy to be the centre of attention in a group.\n" +
            "\t• Your biggest fear is conflict and confrontation.",
            
            "Communicating with a person with high green energy don’t:\n\n" +
            "\t• Push them to make quick decisions or put them on a spot\n" +
            "\t• Try to dominate the discussion or decide for them\n" +
            "\t• Come unexpected\n" +
            "\t• Take advantage of their patience and support or be insincere\n" +
            "\t• Make wild claims or demands\n" +
            "\t• Be disrespectful",
            
            "Communicating with a person with high green energy do:\n\n" +
            "\t• Be friendly and show them you care about them genuinely\n" +
            "\t• Ask their opinion give time to answer\n" +
            "\t• Talk personal before going into business\n" +
            "\t• Slow your pace down\n" +
            "\t• Develop trust first, be informal"],
        
        .Blue: ["Blue light has a wavelength of about 475 nanometers.\n" +
            "Blue is the color of the sea and sky and as the sea it symbolizes depth.\n" +
            "Blue is often used in high-tech products to suggest precision.\n" +
            "Dark blue is associated with depth, expertise, and stability; it is a preferred color for corporate America.\n" +
            "Having blue green energy you tend to behave...\n" +
            "...as analytical, concise, factual, detail focused, introverted, formal thinking, correct, cautious, conventional, logical, structured, deliberate and systematic.\n\n" +
            "\t• You like things in their place, and are very organized with good time management skills.\n" +
            "\t• You are consistent and tend to perfectionism.\n" +
            "\t• You are an excellent observer of situations and people and you think carefully before sharing your ideas, views and perspectives.\n" +
            "\t• You tend to be a private and discreet person.\n" +
            "\t• You are well aware of your boundaries and you defend them.\n" +
            "\t• You prefer small groups of intimate friends to large crowds of acquaintances.\n" +
            "\t• You like to have all the facts, and then logically deduct the right and correct solutions and answers.\n" +
            "\t• You enjoy working alone. You enjoy understanding the relations cause-effect and how things works.\n" +
            "\t• You value independence, knowledge and intellect.\n" +
            "\t• Your thinking is very realistic and grounded on concrete and tangible things. You excel in considering worst case scenarios and pick out weak points in projects and plans.\n" +
            "\t• You are risk and change averse, unless calculated and necessary.\n" +
            "\t• You look for simplicity out of complexity and look for processes, automation and standards.\n" +
            "\t• You honor your word and your commitments, you are reliable.\n" +
            "\t• You strive to be on time, you even get to meetings and appointments before time.\n" +
            "\t• You need data, research and testing before deciding. You look for supporting evidence in opinions, theories and ideas that are presented to you. You think things through before deciding and acting.\n" +
            "\t• You strive to know and understand the worlds in which you function.\n" +
            "\t• You are disciplined and like to bring structure and organization to what you do.\n" +
            "\t• You like to have clear rules and expect yourself and others to play by them.\n" +
            "\t• Your biggest fear is embarrassment and being criticized.\n" +
            "\t• You are normally calm even under duress but you try to avoid unnecessary stress by careful planning.",
            
            "Communicating with a person with high blue energy don’t:\n\n" +
            "\t• Come across as disorganized\n" +
            "\t• Be late\n" +
            "\t• Change the rules or the routine unexpectedly\n" +
            "\t• Be flippant or pushy\n" +
            "\t• Be vague\n" +
            "\t• Exaggerate claims\n" +
            "\t• Be too emotional",
            
            "Communicating with a person with high blue energy do:\n\n" +
            "\t• Be well prepared\n" +
            "\t• Present full details\n" +
            "\t• Provide data evidence based data and documentation\n" +
            "\t• Put important things in writing\n" +
            "\t• Be factual, specific and logical with your approach\n" +
            "\t• Listen carefully to what is said\n" +
            "\t• Allow time to reflect and respond\n" +
            "\t• Be formal in your approach\n" +
            "\t• Don’t touch him/her especially if it is the first time you meet"]
    ]
    
    static func getResultForPrimaryColor(_ color: PrimaryColor) -> [String] {
        return  results[color]!
    }
    
}

enum PrimaryColor: String {
    case Red
    case Yellow
    case Green
    case Blue
}

enum ColorPriority: String {
    case Primary
    case Secondary
    case Recessive
    case Opposite
}
