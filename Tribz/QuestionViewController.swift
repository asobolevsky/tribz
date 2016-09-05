//
//  QuestionViewController.swift
//  Tribz
//
//  Created by Алексей Соболевский on 30.08.16.
//  Copyright © 2016 Le poisson du Mars. All rights reserved.
//

import UIKit

class QuestionViewController : UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nextStepViewView: UIView!
    @IBOutlet weak var optionsTable: UITableView!
    
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    
    var currentQuestionNumber: Int!
    var optionsArray: NSMutableArray!
    var pointsArray = NSMutableArray(array: [4, 3, 2, 1])
    
    var userProgress: UserProgress!
    var question: Question!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userProgress == nil {
            userProgress = UserProgress()
        }
        
        if currentQuestionNumber == nil {
            currentQuestionNumber = 0
        }
        
        question = QuestionsManager.getQuestionAtIndex(currentQuestionNumber)!
        
        optionsArray = NSMutableArray(array: question.options)
        
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: question.colorSet.background)
        contentView.backgroundColor = UIColor(patternImage: image!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(QuestionViewController.nextStepPressed))
        nextStepViewView.addGestureRecognizer(tapGesture)
        
        optionsTable.separatorColor = UIColor.clearColor()
        optionsTable.backgroundColor = UIColor.clearColor()
        optionsTable.registerNib(UINib(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: "optionCell")
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(QuestionViewController.panGestureRecognized))
        optionsTable.addGestureRecognizer(panGesture)
        
    }
    
    func nextStepPressed() {
        if currentQuestionNumber < QuestionsManager.getQuestions().count - 1 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("QuestionViewController") as! QuestionViewController
            
            vc.currentQuestionNumber = currentQuestionNumber + 1
            
            addPoints(userProgress)
            
            vc.userProgress = userProgress
            
            self.presentViewController(vc, animated: true, completion: nil)
        } else {
            performSegueWithIdentifier("showResultPage", sender: nil)
        }
    }
    
    func addPoints(userProgress: UserProgress) {
        userProgress.redResult += pointsArray[0] as! Int
        userProgress.yellowResult += pointsArray[1] as! Int
        userProgress.greenResult += pointsArray[2] as! Int
        userProgress.blueResult += pointsArray[3] as! Int
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showResultPage" {
            let vc = segue.destinationViewController as! ResultPageViewController
            
            addPoints(userProgress)
            vc.userProgress = userProgress
        }
    }
    
    var snapshot: UIView?                ///< A snapshot of the row user is moving.
    var sourceIndexPath: NSIndexPath?    ///< Initial index path, where gesture begins.
    
    func panGestureRecognized(recognizer: UILongPressGestureRecognizer) {
        let state = recognizer.state;
        let location = recognizer.locationInView(optionsTable)
        let indexPath = optionsTable.indexPathForRowAtPoint(location)
        
        switch (state) {
        case .Began:
            if let indexPath = indexPath {
                sourceIndexPath = indexPath;
                let cell = optionsTable.cellForRowAtIndexPath(indexPath)
                
                if let cell = cell {
                    // Take a snapshot of the selected row using helper method.
                    snapshot = self.customSnapshot(fromView: cell)
                    
                    // Add the snapshot as subview, centered at cell's center...
                    var center = cell.center;
                    snapshot!.center = center;
                    snapshot!.alpha = 0.0;
                    optionsTable.addSubview(snapshot!)
                    
                    UIView.animateWithDuration(0.25, animations: {
                        
                        // Offset for gesture location.
                        center.y = location.y;
                        self.snapshot!.center = center;
                        self.snapshot!.transform = CGAffineTransformMakeScale(1.05, 1.05);
                        self.snapshot!.alpha = 0.98;
                        
                        // Fade out.
                        cell.alpha = 0.0;
                        
                        }, completion: { _ in
                            
                            cell.hidden = true
                            
                    })
                }
            }
        case .Changed:
            var center = snapshot!.center
            center.y = location.y;
            snapshot!.center = center
            
            // Is destination valid and is it different from source?
            if let indexPath = indexPath where !indexPath.isEqual(sourceIndexPath) {
                
                // ... update data source.
                optionsArray.exchangeObjectAtIndex(indexPath.row, withObjectAtIndex:sourceIndexPath!.row)
                pointsArray.exchangeObjectAtIndex(indexPath.row, withObjectAtIndex:sourceIndexPath!.row)
                
                // ... move the rows.
                optionsTable.moveRowAtIndexPath(sourceIndexPath!, toIndexPath:indexPath)
                
                // ... and update source so it is in sync with UI changes.
                sourceIndexPath = indexPath;
            }
            break;
        default:
            // Clean up.
            let cell = optionsTable.cellForRowAtIndexPath(sourceIndexPath!)!
            cell.hidden = false
            cell.alpha = 0.0
            UIView.animateWithDuration(0.25, animations: {
                
                self.snapshot!.center = cell.center
                self.snapshot!.transform = CGAffineTransformIdentity
                self.snapshot!.alpha = 0.0
                
                // Undo fade out.
                cell.alpha = 1.0
                
                }, completion: { _ in
            
                self.sourceIndexPath = nil
                self.snapshot!.removeFromSuperview()
                self.snapshot = nil
                
                })
        }
    }
    
    func customSnapshot(fromView inputView: UIView) -> UIView {
        // Make an image from the input view.
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0)
        inputView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Create an image view.
        let snapshot = UIImageView(image: image)
        snapshot.layer.masksToBounds = false
        snapshot.layer.cornerRadius = 0.0
        snapshot.layer.shadowOffset = CGSizeMake(-5.0, 0.0)
        snapshot.layer.shadowRadius = 5.0
        snapshot.layer.shadowOpacity = 0.4
        
        return snapshot
    }
    
}

//MARK: - UITableViewDataSource
extension QuestionViewController : UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("optionCell") as? OptionTableViewCell
        
        if cell == nil {
            cell = OptionTableViewCell(style: .Default, reuseIdentifier: "optionCell")
        }
        
        cell!.backgroundColor = UIColor.clearColor()
        cell!.optionContentView.backgroundColor = question.colorSet.mainColor
        cell!.dragView.backgroundColor = question.colorSet.accessoryColor
        cell!.optionLabel.text = optionsArray[indexPath.row] as? String
        cell!.showsReorderControl = false
        
        return cell!
    }
    
}