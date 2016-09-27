//
//  HowToAnswerViewController.swift
//  Tribz
//
//  Created by Алексей Соболевский on 14.09.16.
//  Copyright © 2016 Le poisson du Mars. All rights reserved.
//

import UIKit

class HowToAnswerViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nextStepViewView: UIView!
    @IBOutlet weak var backViewView: UIView!
    @IBOutlet weak var optionsTable: UITableView!
    
    @IBOutlet weak var fingerImageView: UIImageView!
    @IBOutlet weak var fingerImageStartConstraint: NSLayoutConstraint!
    @IBOutlet weak var fingerImageFinishConstraint: NSLayoutConstraint!
    
    var optionsArray: [String]!
    var colorSet: ColorSet!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorSet = ColorSet.getColorSet(2)!
        
        let image = UIImage(named: colorSet.background)
        contentView.backgroundColor = UIColor(patternImage: image!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(HowToAnswerViewController.nextStepPressed))
        nextStepViewView.addGestureRecognizer(tapGesture)
        
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(HowToAnswerViewController.backPressed))
        backViewView.addGestureRecognizer(backTapGesture)
        
        optionsArray = ["Option A", "Option B", "Option C", "Option D"]
        
        optionsTable.separatorColor = UIColor.clear
        optionsTable.backgroundColor = UIColor.clear
        optionsTable.clipsToBounds = false
        optionsTable.register(UINib(nibName: "OptionTableViewCell", bundle: nil), forCellReuseIdentifier: "optionCell")
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(QuestionViewController.panGestureRecognized))
        optionsTable.addGestureRecognizer(panGesture)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 3, delay: 1, options: [.repeat, .curveEaseOut], animations: {
            //                self.fingerImageStartConstraint.active = false
            //                self.fingerImageFinishConstraint.active = true
            self.fingerImageView.transform = CGAffineTransform(translationX: 0, y: 140)
            }, completion: { finished in
                if !finished {
                    return
                }
        })

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
            
            fingerImageView.layer.removeAllAnimations()
            fingerImageView.isHidden = true
            
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func nextStepPressed() {
        performSegue(withIdentifier: "showQuestionPage", sender: nil)
    }
    
    func backPressed() {
        _ = self.navigationController?.popViewController(animated: true)
    }

}

//MARK: - UITableViewDataSource
extension HowToAnswerViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "optionCell") as? OptionTableViewCell
        
        if cell == nil {
            cell = OptionTableViewCell(style: .default, reuseIdentifier: "optionCell")
        }
        
        cell!.backgroundColor = UIColor.clear
        cell!.optionContentView.backgroundColor = colorSet.mainColor
        cell!.optionLabel.text = optionsArray[(indexPath as NSIndexPath).row]
        cell!.showsReorderControl = false
        
        return cell!
    }
    
}
