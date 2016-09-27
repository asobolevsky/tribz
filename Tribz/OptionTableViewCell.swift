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
    @IBOutlet weak var optionImage: UIImageView!
    @IBOutlet weak var veilView: UIView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        veilView.isHidden = !selected
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        veilView.isHidden = !highlighted
    }

    
}
