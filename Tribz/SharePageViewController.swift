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
    @IBOutlet weak var backViewView: UIView!
    @IBOutlet weak var nextStepViewView: UIView!
    
    var shareText: String!
    var itunesLink: String!
    var userProgress: UserProgress!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let image = UIImage(named: "screen_1")
        contentView.backgroundColor = UIColor(patternImage: image!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SharePageViewController.nextPressed))
        nextStepViewView.addGestureRecognizer(tapGesture)
        
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(SharePageViewController.backPressed))
        backViewView.addGestureRecognizer(backTapGesture)
        
        userProgress = UserProgress()
        userProgress.questionsResult = retrievePoints()
        
        let primaryColor = userProgress.getPrimaryColor()
        shareText = "My primary color is \(primaryColor.rawValue). What's yours? Discover and find out more about your personality!".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        itunesLink = "https://itunes.apple.com/app/1151347866".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        userProgress.colorsPreference = []
    }
    
    func retrievePoints() -> [[Int]] {
        let userDefaults = UserDefaults.standard
        if let allPoints = userDefaults.value(forKey: "points") {
            return allPoints as! [[Int]]
        }
        
        return []
    }
    
    func nextPressed() {
        performSegue(withIdentifier: "showLearnMorePage", sender: nil)
    }
    
    @IBAction func shareWithFB() {
        let link = "https://www.facebook.com/sharer/sharer.php?src=sp&u=\(itunesLink)&t=Tribz&description=\(shareText)"
        share(link)
    }
    
    @IBAction func shareWithLI() {
        let link = "https://www.linkedin.com/shareArticle?mini=true&url=\(itunesLink)&title=Tribz&summary=\(shareText)"
        share(link)
    }
    
    func share(_ shareLink: String) {
        UIApplication.shared.openURL(URL(string: shareLink)!)
    }
    
    func backPressed() {
        _ = self.navigationController?.popViewController(animated: true)
    }
}
