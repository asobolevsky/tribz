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
    @IBOutlet weak var backViewView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: "screen_3")
        contentView.backgroundColor = UIColor(patternImage: image!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(AboutPageViewController.nextStepPressed))
        nextStepViewView.addGestureRecognizer(tapGesture)
        
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(AboutPageViewController.backPressed))
        backViewView.addGestureRecognizer(backTapGesture)
    }
    
    func nextStepPressed() {
        performSegue(withIdentifier: "showHowToAnswerPage", sender: nil)
    }
    
    func backPressed() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}
