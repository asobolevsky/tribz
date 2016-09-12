//
//  AboutPageViewController.swift
//  Tribz
//
//  Created by Алексей Соболевский on 30.08.16.
//  Copyright © 2016 Le poisson du Mars. All rights reserved.
//

import UIKit

class AboutPageViewController : UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nextStepViewView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: "screen_2")
        contentView.backgroundColor = UIColor(patternImage: image!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AboutPageViewController.nextStepPressed))
        nextStepViewView.addGestureRecognizer(tapGesture)
    }
    
    func nextStepPressed() {
        performSegueWithIdentifier("showQuestionPage", sender: nil)
    }
    
    @IBAction func prevStepPressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}