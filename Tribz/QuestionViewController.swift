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
    @IBOutlet weak var backViewView: UIView!
    @IBOutlet weak var optionsTable: UITableView!
    
    @IBOutlet weak var tableHeightConstraint: NSLayoutConstraint!
    
    var currentQuestionNumber: Int!
    var optionsArray = [String]()
    var pointsArray = [Int]()
    
    var question: Question!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if currentQuestionNumber == nil {
            currentQuestionNumber = 0
        }
        
        question = QuestionsManager.getQuestionAtIndex(currentQuestionNumber)!
        
        let maxIndex = question.options.count - 1
        let shuffledIndices = (0...maxIndex).shuffle()
        
        for idx in shuffledIndices {
            optionsArray.append(question.options[idx])
            pointsArray.append(question.optionPoints[idx])
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: question.colorSet.background)
        contentView.backgroundColor = UIColor(patternImage: image!)
        
        let nextTapGesture = UITapGestureRecognizer(target: self, action: #selector(QuestionViewController.nextStepPressed))
        nextStepViewView.addGestureRecognizer(nextTapGesture)
        
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(QuestionViewController.backPressed))
        backViewView.addGestureRecognizer(backTapGesture)
        
        optionsTable.separatorColor = UIColor.clear
        optionsTable.backgroundColor = UIColor.clear
        optionsTable.clipsToBounds = false
        optionsTable.register(UINib(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: "optionCell")
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(QuestionViewController.panGestureRecognized))
        optionsTable.addGestureRecognizer(panGesture)
        
    }
    
    func nextStepPressed() {
        if currentQuestionNumber < QuestionsManager.getQuestions().count - 1 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController
            
            vc.currentQuestionNumber = currentQuestionNumber + 1
            
            addPoints()
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            performSegue(withIdentifier: "showUserInfoQuestionPage", sender: nil)
        }
    }
    
    func backPressed() {
        // show prev question
        if currentQuestionNumber > 0 {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController
            
            vc.currentQuestionNumber = currentQuestionNumber - 1
            
            dropLastPoints()
        }
        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func addPoints() {
        var points: [[Int]]
        if let allPoints = retrievePoints() {
            points = allPoints
            points.append(pointsArray as AnyObject as! [Int])
        } else {
            points = [pointsArray as AnyObject as! [Int]]
        }
        
        let userDefaults = UserDefaults.standard
        userDefaults.setValue(points, forKey: "points")
        userDefaults.synchronize() // don't forget this!!!!
    }
    
    func dropLastPoints() {
        if var points = retrievePoints() {
            let userDefaults = UserDefaults.standard
            let _ = points.removeLast()
            userDefaults.setValue(points, forKey: "points")
            userDefaults.synchronize() // don't forget this!!!!
        }
    }
    
    func retrievePoints() -> [[Int]]? {
        let userDefaults = UserDefaults.standard
        if let allPoints = userDefaults.value(forKey: "points") {
            return allPoints as? [[Int]]
        }
        
        return nil
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showUserInfoQuestionPage" {
            addPoints()
        }
    }
    
    var snapShot: UIView?                ///< A snapshot of the row user is moving.
    var sourceIndexPath: IndexPath?    ///< Initial index path, where gesture begins.
    
    func panGestureRecognized(_ sender: UILongPressGestureRecognizer) {
        let state = sender.state
        let location = sender.location(in: optionsTable)
        
        switch state {
        case .began:
            guard let indexPath = optionsTable.indexPathForRow(at: location) else {
                restoreCellsState()
                return
            }
            
            sourceIndexPath = indexPath
            guard let cell = optionsTable.cellForRow(at: indexPath) else {
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
            UIView.animate(withDuration: 0.25, animations: {
                // Offset for gesture location.
                center.y = location.y
                self.snapShot?.center = center
                self.snapShot?.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                self.snapShot?.alpha = 0.98
                
                cell.alpha = 0.0
                }, completion: { _ in
                    cell.isHidden = true
            })
        case .changed:
            guard let indexPath = optionsTable.indexPathForRow(at: location) else {
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
            if indexPath != sourceIndexPathTmp {
                
                // ... update data source.
                swap(&optionsArray[(indexPath as NSIndexPath).row], &optionsArray[(sourceIndexPath! as NSIndexPath).row])
                swap(&pointsArray[(indexPath as NSIndexPath).row], &pointsArray[(sourceIndexPath! as NSIndexPath).row])
                
                // ... move the rows.
                optionsTable.moveRow(at: sourceIndexPath!, to:indexPath)
                
                // ... and update source so it is in sync with UI changes.
                sourceIndexPath = indexPath;
            }
            
        default:
            guard let sourceIndexPathTmp = sourceIndexPath else {
                restoreCellsState()
                return
            }
            guard let cell = optionsTable.cellForRow(at: sourceIndexPathTmp) else {
                restoreCellsState()
                return
            }
            cell.isHidden = false
            cell.alpha = 0.0
            
            UIView.animate(withDuration: 0.25, animations: {
                self.snapShot?.center = cell.center
                self.snapShot?.transform = CGAffineTransform.identity
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
    
    func customSnapShotFromView(_ inputView: UIView) -> UIImageView{
        // Make an image from the input view.
        UIGraphicsBeginImageContextWithOptions(inputView.bounds.size, false, 0)
        inputView.layer.render(in: UIGraphicsGetCurrentContext()!)
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
            cell.isHidden = false
        }
    }
    
}

//MARK: - UITableViewDataSource
extension QuestionViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsArray.count
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
            cell!.optionLabel.text = optionsArray[(indexPath as NSIndexPath).row]
        } else if question.optionsType == .image {
            cell!.optionLabel.isHidden = true
            cell!.optionImage.isHidden = false
            cell!.optionImage.image = UIImage(named: optionsArray[(indexPath as NSIndexPath).row])
        
        }
        cell!.showsReorderControl = false
        
        return cell!
    }
    
}
