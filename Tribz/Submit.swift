//
//  Submit.swift
//  Tribz
//
//  Created by Алексей Соболевский on 09.09.16.
//  Copyright © 2016 Le poisson du Mars. All rights reserved.
//

import Foundation

class Submit {

    var email: String?
    var age: Int?
    var weight: Int?
    var height: Int?
    var sleep: Int?
 
    let deviceId: String!
    let red: Int!
    let yellow: Int!
    let green: Int!
    let blue: Int!
    
    init(deviceId: String, red: Int, yellow: Int, green: Int, blue: Int) {
        self.deviceId = deviceId
        self.red = red
        self.yellow = yellow
        self.green = green
        self.blue = blue
    }
    
    func preparedDateForSubmit() -> String {
        var result = "deviceId=\(deviceId)&red=\(red)&yellow=\(yellow)&green=\(green)&blue=\(blue)"
        
        if let email = email {
            result += "&email=\(email)"
        }
        if let age = age {
            result += "&age=\(age)"
        }
        if let weight = weight {
            result += "&weight=\(weight)"
        }
        if let height = height {
            result += "&height=\(height)"
        }
        if let sleep = sleep {
            result += "&sleep=\(sleep)"
        }
        
        return result
    }
    
}