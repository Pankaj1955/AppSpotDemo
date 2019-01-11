//
//  LoginViewController.swift
//  AppSpotDemo
//
//  Created by Pankaj on 10/01/19.
//

import UIKit

class LoginViewController: UIViewController,UITextFieldDelegate{
    
    var dataController:DataContoller!
    @IBOutlet var emailTextField: UITextField!
    var emailString:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated:true);


    }
    @IBAction func loginAction(_ sender: Any) {
        
        
        if self.isValidEmail(testStr: self.emailTextField.text!){
            
            self.emailString = self.emailTextField.text!
            SingleTon.sharedInstance.storeUserEmail(userEmail: self.emailTextField.text!)
            SingleTon.sharedInstance.setLogin()
            
            let vcInstance = self.storyboard?.instantiateViewController(withIdentifier: "ProfileListTableViewController") as! ProfileListTableViewController
            vcInstance.emailString = emailString
            vcInstance.dataController = self.dataController
            self.navigationController?.pushViewController(vcInstance, animated: true)

        }else{
            let alert = UIAlertController(title: Constants.kAppName, message: Constants.kEmail, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
    func textViewShouldReturn(_ textView: UITextView!) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
}
