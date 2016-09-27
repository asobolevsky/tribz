//
//  SquareResultPageViewController.swift
//  Tribz
//
//  Created by Алексей Соболевский on 13.09.16.
//  Copyright © 2016 Le poisson du Mars. All rights reserved.
//

import UIKit

class SquareResultPageViewController: UIViewController {
    
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var nextStepViewView: UIView!
    @IBOutlet weak var backViewView: UIView!
    
    @IBOutlet weak var primarySquareView: UIView!
    @IBOutlet weak var secondarySquareView: UIView!
    @IBOutlet weak var recessiveSquareView: UIView!
    @IBOutlet weak var oppositeSquareView: UIView!
    
    @IBOutlet weak var primarySquareButton: UIButton!
    @IBOutlet weak var secondarySquareButton: UIButton!
    @IBOutlet weak var recessiveSquareButton: UIButton!
    @IBOutlet weak var oppositeSquareButton: UIButton!
    
    var userProgress: UserProgress!
    var selectedColor: PrimaryColor!
    var colorPriority: ColorPriority!
    
    var primaryColor: PrimaryColor!
    var secondaryColor: PrimaryColor!
    var recessiveColor: PrimaryColor!
    var oppositeColor: PrimaryColor!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userProgress = UserProgress()
        userProgress.questionsResult = retrievePoints()
        
        let colorsPercentageArray = userProgress.getColorsPercentage() as AnyObject as! [Int]
        let sortedColorsPercentageArray = colorsPercentageArray.sorted()
        
        let image = UIImage(named: "screen_8")
        contentView.backgroundColor = UIColor(patternImage: image!)
        
        oppositeSquareButton.setTitle("\(sortedColorsPercentageArray[0]) %", for: UIControlState())
        recessiveSquareButton.setTitle("\(sortedColorsPercentageArray[1]) %", for: UIControlState())
        secondarySquareButton.setTitle("\(sortedColorsPercentageArray[2]) %", for: UIControlState())
        primarySquareButton.setTitle("\(sortedColorsPercentageArray[3]) %", for: UIControlState())
        
        primaryColor = userProgress.getPrimaryColor()
        secondaryColor = userProgress.getSecondaryColor()
        recessiveColor = userProgress.getRecessiveColor()
        oppositeColor = userProgress.getOppositeColor()
        
        setSquareViewColor(primarySquareView, color: primaryColor)
        setSquareViewColor(secondarySquareView, color: secondaryColor)
        setSquareViewColor(recessiveSquareView, color: recessiveColor)
        setSquareViewColor(oppositeSquareView, color: oppositeColor)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SquareResultPageViewController.nextStepPressed))
        nextStepViewView.addGestureRecognizer(tapGesture)
        
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(SquareResultPageViewController.backPressed))
        backViewView.addGestureRecognizer(backTapGesture)

//        https://www.appcoda.com/ios-charts-api-tutorial/
//        Площадь сектора должна соответствовать процентам, а цвет лэйблов Primary Secondary Recessive Opposite тому цвету, который получился.
//        
//        Верхний правый всегда Primary, нижний правый всегда Secondary, нижний левый Recessive, верхний левый Opposite

    }
    
    func setSquareViewColor(_ square: UIView, color: PrimaryColor) {
        switch color {
        case .Red:
            square.backgroundColor = UIColor(red: 0.713725490196078, green: 0.0, blue: 0.0509803921568627, alpha: 0.95)
        case .Yellow:
            square.backgroundColor = UIColor(red: 0.996078431372549, green: 0.8, blue: 0.105882352941176, alpha: 0.95)
        case .Green:
            square.backgroundColor = UIColor(red: 0.0588235294117647, green: 0.43921568627451, blue: 0.00784313725490196, alpha: 0.95)
        case .Blue:
            square.backgroundColor = UIColor(red: 0.0549019607843137, green: 0.435294117647059, blue: 0.776470588235294, alpha: 0.95)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retrievePoints() -> [[Int]] {
        let userDefaults = UserDefaults.standard
        if let allPoints = userDefaults.value(forKey: "points") {
            return allPoints as! [[Int]]
        }
        
        return []
    }
    
    @IBAction func showDetailResultForPrimaryColor() {
        showDetailedResultPageWithColor(primaryColor, priority: .Primary)
    }
    
    @IBAction func showDetailResultForSecondaryColor() {
        showDetailedResultPageWithColor(secondaryColor, priority: .Secondary)
    }
    
    @IBAction func showDetailResultForRecessiveColor() {
        showDetailedResultPageWithColor(recessiveColor, priority: .Recessive)
    }
    
    @IBAction func showDetailResultForOppositeColor() {
        showDetailedResultPageWithColor(oppositeColor, priority: .Opposite)
    }
    
    func showDetailedResultPageWithColor(_ color: PrimaryColor, priority: ColorPriority) {
        selectedColor = color
        colorPriority = priority
        performSegue(withIdentifier: "showResultPage", sender: nil)
    }
    
    func nextStepPressed() {
        performSegue(withIdentifier: "showSharePage", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResultPage" {
            let vc = segue.destination as! ResultPageViewController
            vc.primaryColor = selectedColor
            vc.colorPriority = colorPriority
        }
    }
    
    func backPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}
