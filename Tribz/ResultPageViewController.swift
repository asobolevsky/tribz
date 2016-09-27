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
    
    var currentResultTextSegment: Int!
    var primaryColor: PrimaryColor!
    var colorPriority: ColorPriority!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentResultTextSegment == nil {
            currentResultTextSegment = 0
        }
        
        titleLabel.text = "YOUR \(colorPriority.rawValue.uppercased()) COLOR IS \(primaryColor.rawValue.uppercased())"
        
        let resultText = Result.getResultForPrimaryColor(primaryColor)
        resultTextView.text = resultText[currentResultTextSegment]
        resultTextView.textColor = UIColor.white
        resultTextView.isEditable = true
        resultTextView.font = UIFont.systemFont(ofSize: 15)
        resultTextView.isEditable = false
        
        let image = UIImage(named: "screen_8")
        contentView.backgroundColor = UIColor(patternImage: image!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ResultPageViewController.nextStepPressed))
        nextStepViewView.addGestureRecognizer(tapGesture)
        
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(ResultPageViewController.backPressed))
        backViewView.addGestureRecognizer(backTapGesture)
        
        var backgroundColor: UIColor
        switch primaryColor as PrimaryColor {
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
    
    override func viewDidLayoutSubviews() {
        resultTextView.contentOffset = CGPoint.zero
    }
    
    func retrievePoints() -> [[Int]] {
        let userDefaults = UserDefaults.standard
        if let allPoints = userDefaults.value(forKey: "points") {
            return allPoints as! [[Int]]
        }
        
        return []
    }

    
    func nextStepPressed() {
        if currentResultTextSegment < Result.getResultForPrimaryColor(primaryColor).count - 1 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ResultPageViewController") as! ResultPageViewController

            vc.currentResultTextSegment = currentResultTextSegment + 1
            vc.colorPriority = colorPriority
            vc.primaryColor = primaryColor

            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            performSegue(withIdentifier: "showSharePage", sender: nil)
        }
    }
    
    func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}
