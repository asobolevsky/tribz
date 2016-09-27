//
//  SubmitViewController.swift
//  Tribz
//
//  Created by Алексей Соболевский on 05.09.16.
//  Copyright © 2016 Le poisson du Mars. All rights reserved.
//

func isValidEmail(_ testStr:String) -> Bool {
    // print("validate calendar: \(testStr)")
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
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
        
        let deviceId = UIDevice.current.identifierForVendor!.uuidString
        let colorPercents = userProgress.getColorsPercentage()
        submit = Submit(deviceId: deviceId, red: colorPercents[0] as! Int,
                        yellow: colorPercents[1] as! Int,
                        green: colorPercents[2] as! Int,
                        blue: colorPercents[3] as! Int)
        
        let userDefaults = UserDefaults.standard
        if let allUserInfo = userDefaults.value(forKey: "userInfo") as? [String: Int] {
            
            if let gender = allUserInfo["gender"] {
                submit.gender = gender
            }
            
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
        
        if let email = emailTextField.text , email.characters.count > 0 {
            if !validateFields() {
                showAlert(title: "Error", message: "Enter valid email")
                return
            }
            submit.email = email
        }
        
        let postUrl = URL(string: "http://tribz.site/api/saveResult")
        let request = NSMutableURLRequest(url: postUrl!)
        request.httpMethod = "POST"
        let postString = submit.preparedDataForSubmit()
        request.httpBody = postString.data(using: String.Encoding.utf8)
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil && data != nil else {                                                          // check for fundamental networking error
                print("error=\(error)")
                return
            }
            
            if let httpStatus = response as? HTTPURLResponse , httpStatus.statusCode != 200 {           // check for http errors
                print("statusCode should be 200, but is \(httpStatus.statusCode)")
                print("response = \(response)")
            }
            
            let responseString = String(data: data!, encoding: String.Encoding.utf8)
            print("responseString = \(responseString)")
        }) 
        task.resume()
        
        performSegue(withIdentifier: "showSquarePage", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSquarePage" {
        }
    }
    
    func dismissInputView() {
        activeTextField?.resignFirstResponder()
        activeTextField = nil
    }
    
    func setPickerViewAsInputViewForTextField(_ textfield: UITextField, withPickerData data: NSArray, withPickerViewTag tag: Int) {
        let pickerView = UIPickerView()
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.tag = tag
        
        textfield.inputView = pickerView
    }
    
    func buildAccessoryToolbarWithFrame(_ frame: CGRect) -> UIToolbar {
        let toolBar = UIToolbar(frame: CGRect(x: 0,y: 0,width: frame.width,height: 44))
        toolBar.barStyle = .default
        let barButtonDone = UIBarButtonItem(title: "Done",
                                            style: .plain,
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
        let userDefaults = UserDefaults.standard
        if let allPoints = userDefaults.value(forKey: "points") {
            return allPoints as! [[Int]]
        }
        
        return []
    }
    
    func backPressed() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    //MARK: - UITextFieldDelegate
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
        textField.inputAccessoryView = buildAccessoryToolbarWithFrame(textField.frame)
    }
    
    //MARK: - UIPickerViewDataSource
    // returns the number of 'columns' to display.
    func numberOfComponents(in picker: UIPickerView) -> Int {
        return 1
    }
    
    // returns the # of rows in each component..
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == agePickerViewTag {
            return agePickerData.count
        } else if pickerView.tag == sleepPickerViewTag {
            return sleepPickerData.count
        } else {
            return 0
        }
    }

}
