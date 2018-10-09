//
//  SignInViewController.swift
//  SampleApp
//
//  Created by Silvia Valdez on 9/18/18.
//  Copyright © 2018 Silvia Valdez. All rights reserved.
//

import UIKit
import SwiftyJSON

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: Properties
    @IBOutlet weak var textUserView: UITextField!
    @IBOutlet weak var textPasswordView: UITextField!
    @IBOutlet weak var buttonSignInView: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide navigation bar.
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        // Hide activity indicator.
        activityIndicatorView?.isHidden = true
        
        // Disable Sign In button as the fields are empty.
        buttonSignInView?.isEnabled = false
        
        // Handle the text field's user input through delegate callbacks.
        textUserView?.delegate = self
        textPasswordView?.delegate = self
    }
    
    // MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide keyboard.
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if (hasFilledFields()) {
            // Enable button if both fields were filled.
            buttonSignInView.isEnabled = true
        }
    }
    
    // MARK: Actions and related functions
    @IBAction func tryToSignIn(_ sender: UIButton) {
        showActivityIndicator(true)
        
        if (hasValidCredentials()) {
            signIn()
        } else {
            showActivityIndicator(false)
            
            let title = "Wrong credentials"
            let message = "User or password are invalid, try again!"
            showAlert(title, message)
        }
    }
    
    private func showActivityIndicator(_ show: Bool) {
        if (show) {
            activityIndicatorView?.startAnimating()
            activityIndicatorView?.isHidden = false
        } else {
            activityIndicatorView?.stopAnimating()
            activityIndicatorView?.isHidden = true
        }
    }
    
    private func goToMainScreen() {
        // Navigate to MainViewController.
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let tableViewController = storyBoard.instantiateViewController(withIdentifier: "TableViewController") as! UITableViewController
        self.present(tableViewController, animated: true, completion: nil)
    }
    
    private func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
                case .default:
                    print("OK!")
                
                case .cancel:
                    print("Cancel")
                
                case .destructive:
                    print("Destructive")
            }}))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: Field validations
    
    private func getUser() -> String {
        return textUserView?.text ?? ""
    }
    
    private func getPassword() -> String {
        return textPasswordView?.text ?? ""
    }
    
    private func hasFilledFields() -> Bool {
        return !(getUser().isEmpty)
            && !(getPassword().isEmpty)
    }
 
    private func validUser() -> Bool {
        return (getUser().count >= 6)
    }
    
    private func validPassword() -> Bool {
        return (getPassword().count >= 6)
    }
    
    private func hasValidCredentials() -> Bool {
        return (validUser()) && (validPassword())
    }
    
    // MARK: REST service
    
    private func onSuccess(_ data: Data) {
        // Do this on main thread
        DispatchQueue.main.async {
            do {
                let json = try JSON(data: data)
                print("Data: \(json)")
                
                if let _ = json["data"].dictionary {
                    if json["data"]["id"].exists() {
                        self.showActivityIndicator(false)
                        self.goToMainScreen()
                    } else {
                        self.onFailure()
                    }
                }
            } catch {
                print("Error getting data")
            }
        }
    }
    
    private func onFailure() {
        // Do this on main thread
        DispatchQueue.main.async {
            print("NULL data")
            self.showActivityIndicator(false)
            
            let title = "Oops!"
            let message = "Something went wrong, try again"
            self.showAlert(title, message)
        }
    }
    
    private func signIn() {
        let params = ["username":getUser(), "password":getPassword()] as Dictionary<String, String>
        
        var request = URLRequest(url: URL(string: "https://demo1976201.mockable.io/api/auth/sign_in")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            // Manage response
            if (response != nil) {
                if let httpResponse = response as? HTTPURLResponse {
                    print("Status code: \(httpResponse.statusCode)")
                } else {
                    print("Cannot get status code from request")
                }
            } else {
                print("NULL response")
            }
            
            // Manage received data
            if (data != nil) {
                self.onSuccess(data!)
            } else {
                self.onFailure()
            }
        })
        
        task.resume()
    }
    
}
