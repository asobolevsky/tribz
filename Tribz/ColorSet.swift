//
//  ColorSet.swift
//  Tribz
//
//  Created by Алексей Соболевский on 05.09.16.
//  Copyright © 2016 Le poisson du Mars. All rights reserved.
//

import UIKit

class ColorSet: NSObject {

    let background: String
    let mainColor: UIColor
    let accessoryColor: UIColor
    
    private static let colorSets = [
        ColorSet(background: "screen_3",
            mainColor: UIColor(red: 0.933333333333333, green: 0.643137254901961, blue: 0.125490196078431, alpha: 1.0),
            accessoryColor: UIColor(red: 0.874509803921569, green: 0.396078431372549, blue: 0.141176470588235, alpha: 1.0)),
        ColorSet(background: "screen_5",
            mainColor: UIColor(red: 0.835294117647059, green: 0.243137254901961, blue: 0.141176470588235, alpha: 1.0),
            accessoryColor: UIColor(red: 0.682352941176471, green: 0.129411764705882, blue: 0.129411764705882, alpha: 1.0)),
        ColorSet(background: "screen_7",
            mainColor: UIColor(red: 0.117647058823529, green: 0.133333333333333, blue: 0.392156862745098, alpha: 1.0),
            accessoryColor: UIColor(red: 0.149019607843137, green: 0.372549019607843, blue: 0.607843137254902, alpha: 1.0)),
        ColorSet(background: "screen_2",
            mainColor: UIColor(red: 0.454901960784314, green: 0.709803921568627, blue: 0.2, alpha: 1.0),
            accessoryColor: UIColor(red: 0.207843137254902, green: 0.568627450980392, blue: 0.2, alpha: 1.0))
    ]
    
    init(background: String, mainColor: UIColor, accessoryColor: UIColor) {
        self.background = background
        self.mainColor = mainColor
        self.accessoryColor = accessoryColor
    }
    
    static func getColorSet(index: Int) -> ColorSet? {
        guard index <= colorSets.count else {
            return nil
        }
    
        return colorSets[index]
    }
    
}
