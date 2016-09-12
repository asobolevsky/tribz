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
    var pointsArray: NSMutableArray!
    
    var question: Question!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentQuestionNumber == nil {
            currentQuestionNumber = 0
        }
        
        question = QuestionsManager.getQuestionAtIndex(currentQuestionNumber)!
        
        optionsArray = NSMutableArray(array: question.options)
        pointsArray = NSMutableArray(array: question.optionPoints)
        
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: question.colorSet.background)
        contentView.backgroundColor = UIColor(patternImage: image!)
        
        let nextTapGesture = UITapGestureRecognizer(target: self, action: #selector(QuestionViewController.nextStepPressed))
        nextStepViewView.addGestureRecognizer(nextTapGesture)
        
        optionsTable.separatorColor = UIColor.clearColor()
        optionsTable.backgroundColor = UIColor.clearColor()
        optionsTable.clipsToBounds = false
        optionsTable.registerNib(UINib(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: "optionCell")
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(QuestionViewController.panGestureRecognized))
        optionsTable.addGestureRecognizer(panGesture)
        
    }
    
    func nextStepPressed() {
        if currentQuestionNumber < QuestionsManager.getQuestions().count - 1 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("QuestionViewController") as! QuestionViewController
            
            vc.currentQuestionNumber = currentQuestionNumber + 1
            
            addPoints()
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            performSegueWithIdentifier("showResultPage", sender: nil)
        }
    }
    
    @IBAction func prevStepPressed() {
        // show prev question
        if currentQuestionNumber > 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewControllerWithIdentifier("QuestionViewController") as! QuestionViewController
            
            vc.currentQuestionNumber = currentQuestionNumber - 1
            
            dropLastPoints()
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func addPoints() {
        var points: [[Int]]
        if let allPoints = retrievePoints() {
            points = allPoints
            points.append(pointsArray as AnyObject as! [Int])
        } else {
            points = [pointsArray as AnyObject as! [Int]]
        }
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(points, forKey: "points")
        userDefaults.synchronize() // don't forget this!!!!
    }
    
    func dropLastPoints() {
        if var points = retrievePoints() {
            let userDefaults = NSUserDefaults.standardUserDefaults()
            let _ = points.removeLast()
            userDefaults.setValue(points, forKey: "points")
            userDefaults.synchronize() // don't forget this!!!!
        }
    }
    
    func retrievePoints() -> [[Int]]? {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let allPoints = userDefaults.valueForKey("points") {
            return allPoints as? [[Int]]
        }
        
        return nil
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showResultPage" {
            addPoints()
        }
    }
    
    var snapShot: UIView?                ///< A snapshot of the row user is moving.
    var sourceIndexPath: NSIndexPath?    ///< Initial index path, where gesture begins.
    
    func panGestureRecognized(sender: UILongPressGestureRecognizer) {
        let state = sender.state
        let location = sender.locationInView(optionsTable)
        
        switch state {
        case .Began:
            guard let indexPath = optionsTable.indexPathForRowAtPoint(location) else {
                restoreCellsState()
                return
            }
            
            sourceIndexPath = indexPath
            guard let cell = optionsTable.cellForRowAtIndexPath(indexPath) else {
                restoreCellsState()
                return
            }
            
            //Take a snapshot of the selected row using helper method.
            snapShot = customSnapShotFromView(cell)
            
            // Add the snapshot as subview, centered at cell's center...
            var center = CGPoint(x: cell.center.x, y: cell.center.y)
            snapShot?.center = center
            snapShot?.alpha = 0.0
            optionsTable.addSubview(snapShot!)
            UIView.animateWithDuration(0.25, animations: {
                // Offset for gesture location.
                center.y = location.y
                self.snapShot?.center = center
                self.snapShot?.transform = CGAffineTransformMakeScale(1.05, 1.05)
                self.snapShot?.alpha = 0.98
                
                cell.alpha = 0.0
                }, completion: { _ in
                    cell.hidden = true
            })
        case .Changed:
            guard let indexPath = optionsTable.indexPathForRowAtPoint(location) else {
                restoreCellsState()
                return
            }
            guard let snapShot = snapShot else {
                restoreCellsState()
                return
            }
            guard let sourceIndexPathTmp = sourceIndexPath else {
                restoreCellsState()
                return
            }
            var center = snapShot.center
            center.y = location.y
            snapShot.center = center
            
            // Is destination valid and is it different from source?
            if !indexPath.isEqual(sourceIndexPathTmp) {
                
                // ... update data source.
                optionsArray.exchangeObjectAtIndex(indexPath.row, withObjectAtIndex:sourceIndexPath!.row)
                pointsArray.exchangeObjectAtIndex(indexPath.row, withObjectAtIndex:sourceIndexPath!.row)
                
                // ... move the rows.
                optionsTable.moveRowAtIndexPath(sourceIndexPath!, toIndexPath:indexPath)
                
                // ... and update source so it is in sync with UI changes.
                sourceIndexPath = indexPath;
            }
            
        default:
            guard let sourceIndexPathTmp = sourceIndexPath else {
                restoreCellsState()
                return
            }
            guard let cell = optionsTable.cellForRowAtIndexPath(sourceIndexPathTmp) else {
                restoreCellsState()
                return
            }
            cell.hidden = false
            cell.alpha = 0.0
            
            UIView.animateWithDuration(0.25, animations: {
                self.snapShot?.center = cell.center
                self.snapShot?.transform = CGAffineTransformIdentity
                self.snapShot?.alpha = 0.0
                
                cell.alpha = 1.0
                }, completion: { _ in
                    self.sourceIndexPath = nil
                    self.snapShot?.removeFromSuperview()
                    self.snapShot = nil
                    self.restoreCellsState()
            })
        }
    }
    
    func customSnapShotFromView(inputView: UIView) -> UIImageView{
        // Make an image from the input view.
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0)
        inputView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let snapshot = UIImageView(image: image)
        snapshot.layer.masksToBounds = false
        snapshot.layer.cornerRadius = 0.0
        snapshot.layer.shadowOffset = CGSize(width: -5.0, height: 0.0)
        snapshot.layer.shadowRadius = 5.0
        snapshot.layer.shadowOpacity = 0.4
        
        return snapshot
    }
    
    func restoreCellsState() {
        for cell in optionsTable.visibleCells {
            cell.alpha = 1.0
            cell.hidden = false
        }
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
        cell!.optionLabel.text = optionsArray[indexPath.row] as? String
        cell!.showsReorderControl = false
        
        return cell!
    }
    
}