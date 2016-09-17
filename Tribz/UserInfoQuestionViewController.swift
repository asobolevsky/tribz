//
//  UserInfoQuestionViewController.swift
//  Tribz
//
//  Created by Алексей Соболевский on 14.09.16.
//  Copyright © 2016 Le poisson du Mars. All rights reserved.
//

import UIKit

class UserInfoQuestionViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nextStepViewView: UIView!
    @IBOutlet weak var backViewView: UIView!
    @IBOutlet weak var optionsTable: UITableView!
    @IBOutlet weak var questionTitleLabel: UILabel!
    
    var currentQuestionNumber: Int!
    var question: Question!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentQuestionNumber == nil {
            currentQuestionNumber = 0
        }
        
        question = QuestionsManager.getUserInfoQuestionAtIndex(currentQuestionNumber)!
        
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: question.colorSet.background)
        contentView.backgroundColor = UIColor(patternImage: image!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UserInfoQuestionViewController.nextStepPressed))
        nextStepViewView.addGestureRecognizer(tapGesture)
        
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(UserInfoQuestionViewController.backPressed))
        backViewView.addGestureRecognizer(backTapGesture)
        
        questionTitleLabel.text = question.question
        
        optionsTable.separatorColor = UIColor.clearColor()
        optionsTable.backgroundColor = UIColor.clearColor()
        optionsTable.clipsToBounds = false
        optionsTable.registerNib(UINib(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: "optionCell")
    }
    
    func nextStepPressed() {
        if currentQuestionNumber < QuestionsManager.getUserInfoQuestions().count - 1 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("UserInfoQuestionViewController") as! UserInfoQuestionViewController
            
            vc.currentQuestionNumber = currentQuestionNumber + 1
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            performSegueWithIdentifier("showSubmitPage", sender: nil)
        }
        
        if let indexPath = optionsTable.indexPathForSelectedRow {
            let questionType = UserInfoQuestionType(rawValue: currentQuestionNumber) ?? .InvalidType
            
            switch questionType {
            case .Age:
                addUserInfo("age", value: indexPath.row)
            case .Height:
                addUserInfo("height", value: indexPath.row)
            case .Weight:
                addUserInfo("weight", value: indexPath.row)
            case .Sleep:
                addUserInfo("sleep", value: indexPath.row)
            case .InvalidType:
                print("Invalid question")
            }
        }
    }
    
    func backPressed() {
        // show prev question
        if currentQuestionNumber > 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("UserInfoQuestionViewController") as! UserInfoQuestionViewController
            
            let questionType = UserInfoQuestionType(rawValue: currentQuestionNumber) ?? .InvalidType
            
            switch questionType {
            case .Age:
                dropUserInfo("age")
            case .Height:
                dropUserInfo("height")
            case .Weight:
                dropUserInfo("weight")
            case .Sleep:
                dropUserInfo("sleep")
            case .InvalidType:
                print("Invalid question")
            }
            
            vc.currentQuestionNumber = currentQuestionNumber - 1
        } else if currentQuestionNumber == 0 {
            dropLastPoints()
        }
        
        self.navigationController?.popViewControllerAnimated(true)
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
    
    func addUserInfo(title: String, value: Int) {
        var allUserInfo = [String: Int]()
        if let userInfo = retrieveUserInfo() {
            allUserInfo = userInfo
        }
        allUserInfo[title] = value
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(allUserInfo, forKey: "userInfo")
        userDefaults.synchronize() // don't forget this!!!!
    }
    
    func dropUserInfo(title: String) {
        if var userInfo = retrieveUserInfo() {
            let userDefaults = NSUserDefaults.standardUserDefaults()
            let _ = userInfo.removeValueForKey(title)
            userDefaults.setValue(userInfo, forKey: "userInfo")
            userDefaults.synchronize() // don't forget this!!!!
        }
    }
    
    func retrieveUserInfo() -> [String: Int]? {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let allUserInfo = userDefaults.valueForKey("userInfo") {
            return allUserInfo as? [String: Int]
        }
        
        return nil
    }
    
}

//MARK: - UITableViewDataSource
extension UserInfoQuestionViewController : UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return question.options.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("optionCell") as? OptionTableViewCell
        
        if cell == nil {
            cell = OptionTableViewCell(style: .Default, reuseIdentifier: "optionCell")
        }
        
        cell!.backgroundColor = UIColor.clearColor()
        cell!.optionContentView.backgroundColor = question.colorSet.mainColor
        cell!.optionLabel.text = question.options[indexPath.row]
        cell!.showsReorderControl = false
        
        return cell!
    }
    
}
