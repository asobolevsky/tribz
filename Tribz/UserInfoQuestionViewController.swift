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
        
        question = QuestionsManager.getQuestionAtIndex(currentQuestionNumber)!
        
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: "screen_2")
        contentView.backgroundColor = UIColor(patternImage: image!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(UserInfoQuestionViewController.nextStepPressed))
        nextStepViewView.addGestureRecognizer(tapGesture)
        
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(UserInfoQuestionViewController.backPressed))
        backViewView.addGestureRecognizer(backTapGesture)
    }
    
    func nextStepPressed() {
        if currentQuestionNumber < QuestionsManager.getQuestions().count - 1 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("UserInfoQuestionViewController") as! UserInfoQuestionViewController
            
            vc.currentQuestionNumber = currentQuestionNumber + 1
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            performSegueWithIdentifier("showSubmitPage", sender: nil)
        }
    }
    
    func backPressed() {
        // show prev question
        if currentQuestionNumber > 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("UserInfoQuestionViewController") as! UserInfoQuestionViewController
            
            vc.currentQuestionNumber = currentQuestionNumber - 1
        }
        
        self.navigationController?.popViewControllerAnimated(true)
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
