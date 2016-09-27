//
//  LearnMoreViewController.swift
//  Tribz
//
//  Created by Алексей Соболевский on 21.09.16.
//  Copyright © 2016 Le poisson du Mars. All rights reserved.
//

import UIKit

class LearnMoreViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nextStepViewView: UIView!
    @IBOutlet weak var backViewView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.backgroundColor = UIColor(patternImage: UIImage(named:"screen_3")!)
        
        let mainPageGesture = UITapGestureRecognizer(target: self, action: #selector(LearnMoreViewController.mainPagePressed))
        nextStepViewView.addGestureRecognizer(mainPageGesture)
        
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(LearnMoreViewController.backPressed))
        backViewView.addGestureRecognizer(backTapGesture)
    }
    
    func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func mainPagePressed() {
        self.navigationController?.popToRootViewController(animated: true)
    }

}
