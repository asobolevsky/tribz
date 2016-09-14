//
//  SquareResultPageViewController.swift
//  Tribz
//
//  Created by Алексей Соболевский on 13.09.16.
//  Copyright © 2016 Le poisson du Mars. All rights reserved.
//

import UIKit

class SquareResultPageViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var nextStepViewView: UIView!
    @IBOutlet weak var backViewView: UIView!
    
    @IBOutlet weak var primarySquareView: UIView!
    @IBOutlet weak var secondarySquareView: UIView!
    @IBOutlet weak var recessiveSquareView: UIView!
    @IBOutlet weak var oppositeSquareView: UIView!
    
    @IBOutlet weak var primarySquareLabel: UILabel!
    @IBOutlet weak var secondarySquareLabel: UILabel!
    @IBOutlet weak var recessiveSquareLabel: UILabel!
    @IBOutlet weak var oppositeSquareLabel: UILabel!
    
    var userProgress: UserProgress!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userProgress = UserProgress()
        userProgress.questionsResult = retrievePoints()
        
        let colorsPercentageArray = userProgress.getColorsPercentage() as AnyObject as! [Int]
        let sortedColorsPercentageArray = colorsPercentageArray.sort()
        
        let image = UIImage(named: "screen_8")
        contentView.backgroundColor = UIColor(patternImage: image!)
        
        oppositeSquareLabel.text = "\(sortedColorsPercentageArray[0]) %"
        recessiveSquareLabel.text = "\(sortedColorsPercentageArray[1]) %"
        secondarySquareLabel.text = "\(sortedColorsPercentageArray[2]) %"
        primarySquareLabel.text = "\(sortedColorsPercentageArray[3]) %"
        
        setSquareViewColor(primarySquareView, color: userProgress.getPrimaryColor())
        setSquareViewColor(secondarySquareView, color: userProgress.getSecondaryColor())
        setSquareViewColor(recessiveSquareView, color: userProgress.getRecessiveColor())
        setSquareViewColor(oppositeSquareView, color: userProgress.getOppositeColor())
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SquareResultPageViewController.nextStepPressed))
        nextStepViewView.addGestureRecognizer(tapGesture)
        
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(SquareResultPageViewController.backPressed))
        backViewView.addGestureRecognizer(backTapGesture)

    }
    
    func setSquareViewColor(square: UIView, color: PrimaryColor) {
        switch color {
        case .Red:
            square.backgroundColor = UIColor(red: 0.713725490196078, green: 0.0, blue: 0.0509803921568627, alpha: 0.95)
        case .Yellow:
            square.backgroundColor = UIColor(red: 0.996078431372549, green: 0.8, blue: 0.105882352941176, alpha: 0.95)
        case .Green:
            square.backgroundColor = UIColor(red: 0.0588235294117647, green: 0.43921568627451, blue: 0.00784313725490196, alpha: 0.95)
        case .Blue:
            square.backgroundColor = UIColor(red: 0.0549019607843137, green: 0.435294117647059, blue: 0.776470588235294, alpha: 0.95)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retrievePoints() -> [[Int]] {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let allPoints = userDefaults.valueForKey("points") {
            return allPoints as! [[Int]]
        }
        
        return []
    }
    
    func nextStepPressed() {
        performSegueWithIdentifier("showResultPage", sender: nil)
    }
    
    func backPressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }
}
