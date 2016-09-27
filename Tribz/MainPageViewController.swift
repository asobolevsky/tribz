//
//  ViewController.swift
//  Tribz
//
//  Created by Алексей Соболевский on 26.08.16.
//  Copyright © 2016 Le poisson du Mars. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var startTestView: UIView!

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: "screen_1")
        contentView.backgroundColor = UIColor(patternImage: image!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(MainPageViewController.startTestPressed))
        startTestView.addGestureRecognizer(tapGesture)
        
        self.navigationController?.isNavigationBarHidden = true
        
        let userDefaults = UserDefaults.standard
        userDefaults.removeObject(forKey: "points")
        userDefaults.removeObject(forKey: "userInfo")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions
    func startTestPressed() {
        performSegue(withIdentifier: "showAboutPage", sender: nil)
    }
    
}

