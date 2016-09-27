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
        
        optionsTable.separatorColor = UIColor.clear
        optionsTable.backgroundColor = UIColor.clear
        optionsTable.clipsToBounds = false
        optionsTable.register(UINib(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: "optionCell")
    }
    
    func nextStepPressed() {
        if currentQuestionNumber < QuestionsManager.getUserInfoQuestions().count - 1 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "UserInfoQuestionViewController") as! UserInfoQuestionViewController
            
            vc.currentQuestionNumber = currentQuestionNumber + 1
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            performSegue(withIdentifier: "showSubmitPage", sender: nil)
        }
        
        if let indexPath = optionsTable.indexPathForSelectedRow {
            let questionType = UserInfoQuestionType(rawValue: currentQuestionNumber) ?? .invalidType
            
            switch questionType {
            case .gender:
                addUserInfo("gender", value: (indexPath as NSIndexPath).row)
            case .age:
                addUserInfo("age", value: (indexPath as NSIndexPath).row)
            case .height:
                addUserInfo("height", value: (indexPath as NSIndexPath).row)
            case .weight:
                addUserInfo("weight", value: (indexPath as NSIndexPath).row)
            case .sleep:
                addUserInfo("sleep", value: (indexPath as NSIndexPath).row)
            case .invalidType:
                print("Invalid question")
            }
        }
    }
    
    func backPressed() {
        // show prev question
        if currentQuestionNumber > 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "UserInfoQuestionViewController") as! UserInfoQuestionViewController
            
            let questionType = UserInfoQuestionType(rawValue: currentQuestionNumber) ?? .invalidType
            
            switch questionType {
            case .gender:
                dropUserInfo("gender")
            case .age:
                dropUserInfo("age")
            case .height:
                dropUserInfo("height")
            case .weight:
                dropUserInfo("weight")
            case .sleep:
                dropUserInfo("sleep")
            case .invalidType:
                print("Invalid question")
            }
            
            vc.currentQuestionNumber = currentQuestionNumber - 1
        } else if currentQuestionNumber == 0 {
            dropLastPoints()
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func retrievePoints() -> [[Int]] {
        let userDefaults = UserDefaults.standard
        if let allPoints = userDefaults.value(forKey: "points") {
            return allPoints as! [[Int]]
        }
        
        return []
    }
    
    func dropLastPoints() {
        var points = retrievePoints()
        let userDefaults = UserDefaults.standard
        let _ = points.removeLast()
        userDefaults.setValue(points, forKey: "points")
        userDefaults.synchronize() // don't forget this!!!!
    }
    
    func addUserInfo(_ title: String, value: Int) {
        var allUserInfo = [String: Int]()
        if let userInfo = retrieveUserInfo() {
            allUserInfo = userInfo
        }
        allUserInfo[title] = value
        
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(allUserInfo, forKey: "userInfo")
        userDefaults.synchronize() // don't forget this!!!!
    }
    
    func dropUserInfo(_ title: String) {
        if var userInfo = retrieveUserInfo() {
            let userDefaults = UserDefaults.standard
            let _ = userInfo.removeValue(forKey: title)
            userDefaults.setValue(userInfo, forKey: "userInfo")
            userDefaults.synchronize() // don't forget this!!!!
        }
    }
    
    func retrieveUserInfo() -> [String: Int]? {
        let userDefaults = UserDefaults.standard
        if let allUserInfo = userDefaults.value(forKey: "userInfo") {
            return allUserInfo as? [String: Int]
        }
        
        return nil
    }
    
}

//MARK: - UITableViewDataSource
extension UserInfoQuestionViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return question.options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "optionCell") as? OptionTableViewCell
        
        if cell == nil {
            cell = OptionTableViewCell(style: .default, reuseIdentifier: "optionCell")
        }
        
        cell!.backgroundColor = UIColor.clear
        cell!.optionContentView.backgroundColor = question.colorSet.mainColor
        if question.optionsType == .text {
            cell!.optionImage.isHidden = true
            cell!.optionLabel.isHidden = false
            cell!.optionLabel.text = question.options[(indexPath as NSIndexPath).row]
        } else if question.optionsType == .image {
            cell!.optionLabel.isHidden = true
            cell!.optionImage.isHidden = false
            cell!.optionImage.image = UIImage(named: question.options[(indexPath as NSIndexPath).row])
        }
        cell!.showsReorderControl = false
        
        return cell!
    }
    
}
