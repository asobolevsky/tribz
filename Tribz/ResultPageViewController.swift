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
    @IBOutlet weak var backViewView: UIView!
    
    var userProgress: UserProgress!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userProgress = UserProgress()
        userProgress.questionsResult = retrievePoints()

        let primaryColor = userProgress.getPrimaryColor()
        titleLabel.text = "YOUR PRIMARY COLOR IS \(primaryColor.rawValue.uppercaseString)"
        
        let resultText = Result.getResultForPrimaryColor(primaryColor)
        resultTextView.text = resultText
        resultTextView.textColor = UIColor.whiteColor()
        
        let image = UIImage(named: "screen_8")
        contentView.backgroundColor = UIColor(patternImage: image!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ResultPageViewController.nextStepPressed))
        nextStepViewView.addGestureRecognizer(tapGesture)
        
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(ResultPageViewController.backPressed))
        backViewView.addGestureRecognizer(backTapGesture)
        
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
    
    func retrievePoints() -> [[Int]] {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let allPoints = userDefaults.valueForKey("points") {
            return allPoints as! [[Int]]
        }
        
        return []
    }
    
    func dropLastPoints() {
        var points = retrievePoints()
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let _ = points.removeLast()
        userDefaults.setValue(points, forKey: "points")
        userDefaults.synchronize() // don't forget this!!!!
    }

    
    func nextStepPressed() {
        performSegueWithIdentifier("showUserInfoQuestionPage", sender: nil)
    }
    
    func backPressed() {
        dropLastPoints()
        self.navigationController?.popViewControllerAnimated(true)
    }
}
