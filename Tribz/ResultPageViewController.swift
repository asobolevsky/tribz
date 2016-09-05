//
//  ResultPageViewController.swift
//  Tribz
//
//  Created by Алексей Соболевский on 30.08.16.
//  Copyright © 2016 Le poisson du Mars. All rights reserved.
//

import UIKit

class ResultPageViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var resultTextView: UITextView!
    @IBOutlet weak var resultBodyCont: UIView!
    @IBOutlet weak var nextStepViewView: UIView!
    
    var userProgress: UserProgress!

    override func viewDidLoad() {
        super.viewDidLoad()

        let primaryColor = userProgress.getPrimaryColor()
        titleLabel.text = "YOUR PRIMARY COLOR IS \(primaryColor.rawValue.uppercaseString)"
        
        let resultText = Result.getResultForPrimaryColor(primaryColor)
        resultTextView.text = resultText
        resultTextView.textColor = UIColor.whiteColor()
        
        let image = UIImage(named: "screen_8")
        contentView.backgroundColor = UIColor(patternImage: image!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ResultPageViewController.nextStepPressed))
        nextStepViewView.addGestureRecognizer(tapGesture)
        
        var backgroundColor: UIColor
        switch primaryColor {
        case .Red:
            backgroundColor = UIColor(red: 0.713725490196078, green: 0.0, blue: 0.0509803921568627, alpha: 0.95)
        case .Yellow:
            backgroundColor = UIColor(red: 0.996078431372549, green: 0.8, blue: 0.105882352941176, alpha: 0.95)
        case .Green:
            backgroundColor = UIColor(red: 0.0588235294117647, green: 0.43921568627451, blue: 0.00784313725490196, alpha: 0.95)
        case .Blue:
            backgroundColor = UIColor(red: 0.0549019607843137, green: 0.435294117647059, blue: 0.776470588235294, alpha: 0.95)
        }
        
        resultBodyCont.backgroundColor = backgroundColor
        nextStepViewView.backgroundColor = backgroundColor
        
    }
    
    func nextStepPressed() {
        performSegueWithIdentifier("showSubmitPage", sender: nil)
    }
}
