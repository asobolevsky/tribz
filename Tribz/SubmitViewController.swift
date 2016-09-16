//
//  SubmitViewController.swift
//  Tribz
//
//  Created by Алексей Соболевский on 05.09.16.
//  Copyright © 2016 Le poisson du Mars. All rights reserved.
//

func isValidEmail(testStr:String) -> Bool {
    // print("validate calendar: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluateWithObject(testStr)
}

import UIKit

class SubmitViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nextStepViewView: UIView!
    @IBOutlet weak var backViewView: UIView!
    
    @IBOutlet weak var emailTextField: UITextField!
    
    weak var activeTextField: UITextField?
    
    var agePickerViewTag: Int = 1
    var agePickerData: NSArray!
    var sleepPickerViewTag: Int = 2
    var sleepPickerData: NSArray!

    var userProgress: UserProgress!
    var submit: Submit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userProgress = UserProgress()
        userProgress.questionsResult = retrievePoints()
        
        let deviceId = UIDevice.currentDevice().identifierForVendor!.UUIDString
        let colorPercents = userProgress.getColorsPercentage()
        submit = Submit(deviceId: deviceId, red: colorPercents[0] as! Int,
                        yellow: colorPercents[1] as! Int,
                        green: colorPercents[2] as! Int,
                        blue: colorPercents[3] as! Int)
        
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let allUserInfo = userDefaults.valueForKey("userInfo") as? [String: Int] {
            
            if let age = allUserInfo["age"] {
                submit.age = age
            }
            
            if let height = allUserInfo["height"] {
                submit.height = height
            }
            
            if let weight = allUserInfo["weight"] {
                submit.weight = weight
            }
            
            if let sleep = allUserInfo["sleep"] {
                submit.sleep = sleep
            }
            
        }
        
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: "screen_2")
        contentView.backgroundColor = UIColor(patternImage: image!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SubmitViewController.nextStepPressed))
        nextStepViewView.addGestureRecognizer(tapGesture)
        
        let backTapGesture = UITapGestureRecognizer(target: self, action: #selector(SubmitViewController.backPressed))
        backViewView.addGestureRecognizer(backTapGesture)
    
    }
    
    func nextStepPressed() {
        
        if let email = emailTextField.text where email.characters.count > 0 {
            if !validateFields() {
                showAlert(title: "Error", message: "Enter valid email")
                return
            }
            submit.email = email
        }
        
        let postUrl = NSURL(string: "http://tribz.site/api/saveResult")
        let request = NSMutableURLRequest(URL: postUrl!)
        request.HTTPMethod = "POST"
        let postString = submit.preparedDataForSubmit()
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? NSHTTPURLResponse where httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
        }
        task.resume()
        
        performSegueWithIdentifier("showSquarePage", sender: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showSquarePage" {
        }
    }
    
    func dismissInputView() {
        activeTextField?.resignFirstResponder()
        activeTextField = nil
    }
    
    func setPickerViewAsInputViewForTextField(textfield: UITextField, withPickerData data: NSArray, withPickerViewTag tag: Int) {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.tag = tag
        
        textfield.inputView = pickerView
    }
    
    func buildAccessoryToolbarWithFrame(frame: CGRect) -> UIToolbar {
        let toolBar = UIToolbar(frame: CGRectMake(0,0,CGRectGetWidth(frame),44))
        toolBar.barStyle = .Default
        let barButtonDone = UIBarButtonItem(title: "Done",
                                            style: .Plain,
                                            target: self,
                                            action: #selector(dismissInputView))
        toolBar.items = [barButtonDone]
        return toolBar
    }
    
    func validateFields() -> Bool {
        var isValid = true
        
        if let email = emailTextField.text {
            isValid = isValidEmail(email)
        }
        
        return isValid
    }
    
    func retrievePoints() -> [[Int]] {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        if let allPoints = userDefaults.valueForKey("points") {
            return allPoints as! [[Int]]
        }
        
        return []
    }
    
    func backPressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func showAlert(title title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: nil))
        presentViewController(alert, animated: true, completion: nil)
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(textField: UITextField) {
        activeTextField = textField
        textField.inputAccessoryView = buildAccessoryToolbarWithFrame(textField.frame)
    }
    
    //MARK: - UIPickerViewDataSource
    // returns the number of 'columns' to display.
    func numberOfComponentsInPickerView(picker: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == agePickerViewTag {
            return agePickerData.count
        } else if pickerView.tag == sleepPickerViewTag {
            return sleepPickerData.count
        } else {
            return 0
        }
    }

}
