//
//  SharePageViewController.swift
//  Tribz
//
//  Created by Алексей Соболевский on 14.09.16.
//  Copyright © 2016 Le poisson du Mars. All rights reserved.
//

import UIKit

class SharePageViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var mainPageViewView: UIView!
    
    var shareText: String!
    var itunesLink: String!
    var userProgress: UserProgress!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "screen_1")
        contentView.backgroundColor = UIColor(patternImage: image!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SharePageViewController.mainPagePressed))
        mainPageViewView.addGestureRecognizer(tapGesture)
        
        userProgress = UserProgress()
        userProgress.questionsResult = retrievePoints()
        
        let primaryColor = userProgress.getPrimaryColor()
        shareText = "My primary color is \(primaryColor.rawValue). What's yours? Discover and find out more about your personality!".stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
        itunesLink = "https://itunes.apple.com/app/1151347866".stringByAddingPercentEncodingWithAllowedCharacters(.URLQueryAllowedCharacterSet())
    }
    
    func retrievePoints() -> [[Int]] {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let allPoints = userDefaults.valueForKey("points") {
            return allPoints as! [[Int]]
        }
        
        return []
    }
    
    func mainPagePressed() {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func shareWithFB() {
        let link = "https://www.facebook.com/sharer/sharer.php?src=sp&u=\(itunesLink)&t=Tribz&description=\(shareText)"
        share(link)
    }
    
    @IBAction func shareWithLI() {
        let link = "https://www.linkedin.com/shareArticle?mini=true&url=\(itunesLink)&title=Tribz&summary=\(shareText)"
        share(link)
    }
    
    func share(shareLink: String) {
        UIApplication.sharedApplication().openURL(NSURL(string: shareLink)!)
    }
}
