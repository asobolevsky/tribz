//
//  LearnMoreViewController.swift
//  Tribz
//
//  Created by Алексей Соболевский on 21.09.16.
//  Copyright © 2016 Le poisson du Mars. All rights reserved.
//

import UIKit
import YouTubePlayer

class LearnMoreViewController: UIViewController {
    
    @IBOutlet var playerView: YouTubePlayerView!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nextStepViewView: UIView!
    @IBOutlet weak var backViewView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.backgroundColor = UIColor(patternImage: UIImage(named:"screen_3")!)
        
        playerView.loadVideoID("KK9bwTlAvgo")
        
        let mainPageGesture = UITapGestureRecognizer(target: self, action: #selector(LearnMoreViewController.mainPagePressed))
        nextStepViewView.addGestureRecognizer(mainPageGesture)
        
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(LearnMoreViewController.backPressed))
        backViewView.addGestureRecognizer(backTapGesture)
    }
    
    func backPressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func mainPagePressed() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }

}
