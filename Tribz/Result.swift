//
//  Result.swift
//  Tribz
//
//  Created by Алексей Соболевский on 05.09.16.
//  Copyright © 2016 Le poisson du Mars. All rights reserved.
//

import UIKit

class Result: NSObject {
    
    private static let results: [PrimaryColor: String] = [
        .Red: "Red light has a wavelength of about 650 nanometers.\nRed is the color of fire and blood, so it is associated with energy, war, danger, strength, power and determination.\nRed enhances human metabolism, increases respiration rate, and raises blood pressure.\nStop signs, stoplights, red cross, Ferraris, the first chakra and fire equipment are red.\nIt is a color found in many national flags.\n\n" +
            "Having high red energy you tend to behave...\n" + //bold
            "...as strong leader, fast paced thinker, risk taker, purposeful, critical thinker, driving, strong-willed, less patient, extroverted, competitive, problem solver, direct, outspoken and rational.\nYour focus is on results. You have a strong determination that influences those you interact with and you approach others in a direct and straightforward manner.\nYou enjoy applying your logical mind rigorously to work issues. Achieving a successful outcome supersedes people's feelings.\nYou can really enjoy a good, well thought through argument. You embrace conflict, as it clears the air and allows space to express concerns. You will argue your position forcefully and will not easily concede ground. You may appear aggressive and antagonistic especially to people with high green energy.\nYou take great pleasure in working passionately and purposefully towards your goals.\nYou to set yourself very ambitious targets and have high standards.\nFinishing the job and achieving your goals are very important to you.\nYou tell things as you see them.\nWinning is important to you.\nYou have a high opinion of your own abilities.\nYou work well in a group, where you quickly move to take control to mobilize resources and achieve results.\nYour biggest fear is losing control.\nTime is of essence and you can compromise in quality in order to deliver on time.\n\n" +
            "Communicating with a person with high red energy don’t:\n" + //bold
            "\tBe vague or ramble on\n\tWaffle or hesitate\n\tBecome personal waste their time\n\tAsk irrelevant questions\n\tTry to take control\n\n" +
            "Communicating with a person with high red energy do:\n" + //bold
        "\tGet to business quickly,\n\tBe succinct and precise\n\tGive them facts and few details focus on results and outcomes\n\tSpeak and act confident and direct",
        
        .Yellow: "Yellow light has a wavelength of about 570 nanometers.\nIt is the color of sunshine associated with joy, happiness, optimism and partying: think of the smiley.\nIt is the color of the third chakra.\nYellow is an attention getter: think of taxicabs and of the classic color of Stabilo Boss highlighter.\n" +
            "Having high yellow energy you tend to behave...\n" + //bold
            "...as fun, convincing, engaging, sociable, talkative, expressive, extroverted, feeling, the soul of the party, imaginative, visionary, cheerful, influencing and enthusiastic.\nYou act very informal, very optimistic and impulsive.\nYour enthusiasm is contagious.\nYou are a fast paced thinker and spontaneous.\nYou tend to decide instinctively, without the need of gathering lots of details.\nYou fight routines and get bored quickly.\nYou enjoy and seek the company of others and like being noticed and appreciated.\nYou make new friends very easily.\nYou are persuasive and a source of inspiration.\nYou tend to dominate the conversation. You enjoy and find natural interacting and mingling with strangers and new people.\nWhen it is not possible a vis-a-vis you enjoy and use the phone a lot to converse, discuss, chat, brainstorm with your connections.\nYou think out loud and tend to finishing other people’s sentences.\nYou like having options and flexibility and think in big pictures. You enjoy working in an easygoing and unstructured way.\nYou have a strong imagination and are a vulcan of ideas, you focus on solutions and possibilities.\nYou enjoy working in a team, where you will quickly try to be the center of attention.\nYou fight the status quo and embrace and stimulate change.\nYou tend to wait to the last minute to complete tasks and projects and tend to run out of time.\nYour biggest fear is losing prestige and acknowledgment.\n\n" +
            "Communicating with a person with high yellow energy don’t:\n" + //bold
            "\tBurden them down with routine and bureaucracy get into details\n\tPut them to work alone\n\tBe impersonal\n\tJump right into business issues without taking time to bond first\n\tAct aloof or detached\n\n" +
            "Communicating with a person with high yellow energy do:\n" + //bold
            "\tBe friendly and sociable before mentioning any business talk about options, big pictures and other people\n\tBe open and flexible enthusiastic and energetic\n\tBe fast paced in delivering your ideas\n\tUse humour entertaining and engaging\n\tAppreciate and acknowledge them for their ideas, efforts and input",
        
        .Green: "Yellow light has a wavelength of about 510 nanometers.\nGreen is the color of nature: trees, meadows, forests. It is the color of the fourth chakra (heart chakra). It symbolizes endurance, harmony, care, and stability.\nIt is the most restful color for the human eye. It is the color of free passage in traffic-lights: it symbolizes safety.\n\n" +
            "Having high green energy you tend to behave...\n" + //bold
            "...as laid back, relaxed, patient, reliable, accommodating, feeling, introverted, calm, easy to get along with, focused on relationships, courteous and considerate of people, amenable, caring and reflective.\n" +
            "You are informal in your approach. They are a slower paced thinker.\n" +
            "You are understanding and democratic, therefore you work well one to one and in groups.\n" +
            "You are humble for yourself but well versed in acknowledging the efforts, inputs and achievements of other people.\n" +
            "You are compassionate and fully aware and considering the needs of others with empathy.\n" +
            "You seek harmony, depth in relationships and peace. You defend what you value with determination and persistence.\n" +
            "You do not enjoy conflicts and therefore act as facilitator and pacificator in case of conflicting. Better, you work systematically to prevent potential conflicts through diplomacy\n" +
            "You value people over processes and results.\n" +
            "You make sure all individual perspectives are carefully heard and considered in making choices or decisions. You provide support and listening to people.\n" +
            "Your leadership style is quiet and gentle.\n" +
            "You might say “yes” when in fact is a “no” to maintain peace and to not disappoint.\n" +
            "You don't enjoy to be the centre of attention in a group.\n" +
            "Your biggest fear is conflict and confrontation.\n" +
            "Communicating with a person with high green energy don’t:\n" + //bold
            "\tPush them to make quick decisions or put them on a spot try to dominate the discussion or decide for them\n" +
            "\tCome unexpected\n" +
            "\tTake advantage of their patience and support or be insincere make wild claims or demands\n" +
            "\tBe irrespectful\n" +
            "Communicating with a person with high green energy do:\n" + //bold
            "\tBe friendly and show them you care about them genuinely Ask their opinion give time to answer\n" +
            "\tTalk personal before going into business\n" +
            "\tSlow your pace down\n" +
            "\tDevelop trust first, be informal",
        
        .Blue: "Blue light has a wavelength of about 475 nanometers.\n" +
            "Blue is the color of the sea and sky and as the sea it symbolizes depth.\n" +
            "Blue is often used in high-tech products to suggest precision.\n" +
            "Dark blue is associated with depth, expertise, and stability; it is a preferred color for corporate America.\n" +
            "Having blue green energy you tend to behave...\n" +  //bold
            "...as analytical, concise, factual, detail focused, introverted, formal thinking, correct, cautious, conventional, logical, structured, deliberate and systematic.\n" +
            "You like things in their place, and are very organized with good time management skills.\n" +
            "You are consistent and tend to perfectionism.\n" +
            "You are an excellent observer of situations and people and you think carefully before sharing your ideas, views and perspectives.\n" +
            "You tend to be a private and discreet person.\n" +
            "You are well aware of your boundaries and you defend them.\n" +
            "You prefer small groups of intimate friends to large crowds of acquaintances.\n" +
            "You like to have all the facts, and then logically deduct the right and correct solutions and answers.\n" +
            "You enjoy working alone. You enjoy understanding the relations cause-effect and how things works.\n" +
            "You value independence, knowledge and intellect.\n" +
            "Your thinking is very realistic and grounded on concrete and tangible things. You excel in considering worst case scenarios and pick out weak points in projects and plans.\n" +
            "You are risk and change averse, unless calculated and necessary.\n" +
            "You look for simplicity out of complexity and look for processes, automation and standards.\n" +
            "You honor your word and your commitments, you are reliable.\n" +
            "You strive to be on time, you even get to meetings and appointments before time.\n" +
            "You need data, research and testing before deciding. You look for supporting evidence in opinions, theories and ideas that are presented to you. You think things through before deciding and acting.\n" +
            "You strive to know and understand the worlds in which you function.\n" +
            "You are disciplined and like to bring structure and organization to what you do.\n" +
            "You like to have clear rules and expect yourself and others to play by them.\n" +
            "Your biggest fear is embarrassment and being criticized.\n" +
            "You are normally calm even under duress but you try to avoid unnecessary stress by careful planning.\n" +
            "Communicating with a person with high blue energy don’t:\n" + //bold
            "\tCome across as disorganized\n" +
            "\tBe late\n" +
            "\tChange the rules or the routine unexpectedly be flippant or pushy\n" +
            "\tBe vague\n" +
            "\tExaggerate claims\n" +
            "\tBe too emotional\n" +
            "Communicating with a person with high blue energy do:\n" +  //bold
            "\tBe well prepared\n" +
            "\tPresent full details\n" +
            "\tProvide data evidence based data and documentation\n" +
            "\tPut important things in writing\n" +
            "\tBe factual, specific and logical with your approach\n" +
            "\tListen carefully to what is said\n" +
            "\tAllow time to reflect and respond\n" +
            "\tBe formal in your approach\n" +
            "\tDon’t touch him/her especially if it is the first time you meet"
    ]
    
    static func getResultForPrimaryColor(color: PrimaryColor) -> String {
        return  results[color]!
    }
    
}

enum PrimaryColor: String {
    case Red
    case Yellow
    case Green
    case Blue
}
