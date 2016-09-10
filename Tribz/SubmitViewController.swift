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
    
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var sleepTextField: UITextField!
    
    weak var activeTextField: UITextField?
    
    var agePickerViewTag: Int = 1
    var agePickerData: NSArray!
    var sleepPickerViewTag: Int = 2
    var sleepPickerData: NSArray!

    var userProgress: UserProgress!
    var submit: Submit!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let deviceId = UIDevice.currentDevice().identifierForVendor!.UUIDString
        let colorPercents = userProgress.getColorsPercentage()
        submit = Submit(deviceId: deviceId, red: colorPercents[0] as! Int,
                        yellow: colorPercents[1] as! Int,
                        green: colorPercents[2] as! Int,
                        blue: colorPercents[3] as! Int)
        
        // Do any additional setup after loading the view, typically from a nib.
        let image = UIImage(named: "screen_2")
        contentView.backgroundColor = UIColor(patternImage: image!)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(SubmitViewController.nextStepPressed))
        nextStepViewView.addGestureRecognizer(tapGesture)
        
        agePickerData = (1...100).map { $0 }
        setPickerViewAsInputViewForTextField(ageTextField, withPickerData: agePickerData, withPickerViewTag: agePickerViewTag)
        
        sleepPickerData = ["On my back", "On my belly"]
        setPickerViewAsInputViewForTextField(sleepTextField, withPickerData: sleepPickerData, withPickerViewTag: sleepPickerViewTag)
    }
    
    func nextStepPressed() {
        
        if !validateFields() {
            showAlert(title: "Error", message: "Enter valid email")
            return
        }
        
        showAlert(title: "Congratulations!", message: "Thank you for taking the test")
        
        submit.email = emailTextField.text
        
        if let age = ageTextField.text {
            submit.age = Int(age)
        }
        if let weight = weightTextField.text {
            submit.weight = Int(weight)
        }
        if let height = heightTextField.text {
            submit.height = Int(height)
        }
        if let sleep = sleepTextField.text {
            let idx = sleepPickerData.indexOfObject(sleep)
            submit.sleep = Int(idx)
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
    
    //MARK: - UIPickerViewDelegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == agePickerViewTag {
            return String(agePickerData[row])
        } else if pickerView.tag == sleepPickerViewTag {
            return String(sleepPickerData[row])
        } else {
            return nil
        }
    }

    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == agePickerViewTag {
            ageTextField.text = String(agePickerData[row])
        } else if pickerView.tag == sleepPickerViewTag {
            sleepTextField.text = String(sleepPickerData[row])
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "prevResultPage" {
            let vc = segue.destinationViewController as! ResultPageViewController
            vc.userProgress = userProgress
        }
    }

}
