//
//  OptionTableViewCell.swift
//  Tribz
//
//  Created by Алексей Соболевский on 04.09.16.
//  Copyright © 2016 Le poisson du Mars. All rights reserved.
//

import UIKit

class OptionTableViewCell: UITableViewCell {

    @IBOutlet weak var optionContentView: UIView!
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var dragView: UIView!
    
    override func awakeFromNib() {
        dragView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_4))
    }
    
}
