//
//  SignInViewController.swift
//  SampleApp
//
//  Created by Hunabsys on 9/18/18.
//  Copyright © 2018 Silvia Valdez. All rights reserved.
//

import UIKit

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
        // Hide the keyboard.
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
    @IBAction func signIn(_ sender: UIButton) {
        activityIndicatorView?.startAnimating()
        activityIndicatorView?.isHidden = false
        
//        // Dummy delay to simulate processing... Then, go to Main screen.
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // 2: Number of seconds
            if (self.hasValidCredentials()) {
                self.tryToSignIn(self.getUser(), self.getPassword())
            } else {
                self.activityIndicatorView?.stopAnimating()
                self.activityIndicatorView?.isHidden = true
                
                self.showAlert()
            }
//        }
    }
    
    func goToMainScreen() {
        // Navigate to MainViewController.
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        self.present(mainViewController, animated: true, completion: nil)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: "Wrong credentials", message: "User or password are invalid, try again!", preferredStyle: UIAlertControllerStyle.alert)
        
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
    
    func hasFilledFields() -> Bool {
        return !(textUserView.text?.isEmpty)!
            && !(textPasswordView.text?.isEmpty)!
    }
 
    func validUser(_ user: String) -> Bool {
        // TODO: Implement real user validation
        return (user == "silvia")
    }
    
    func validPassword(_ password: String) -> Bool {
        // TODO: Implement real password validation
        return (password == "mypass")
    }
    
    func getUser() -> String {
        return textUserView?.text ?? ""
    }
    
    func getPassword() -> String {
        return textPasswordView?.text ?? ""
    }
    
    func hasValidCredentials() -> Bool {
        let strUser = getUser()
        let strPassword = getPassword()
        
        return (self.validUser(strUser))
            && (self.validPassword(strPassword))
    }
    
    // MARK: REST service
    
    func tryToSignIn(_ user: String, _ password: String) {
        let params = ["username":user, "password":password] as Dictionary<String, String>
        
        var request = URLRequest(url: URL(string: "https://demo1976201.mockable.io/api/auth/sign_in")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            do {
                if (response != nil) {
                    if let httpResponse = response as? HTTPURLResponse {
                        print("Status code: \(httpResponse.statusCode)")
                    } else {
                        print("Oops! Cannot get status code from request")
                    }
                } else {
                    print("NULL response")
                }
                
                if (data != nil) {
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    print("Data: \(json)")
                    self.goToMainScreen()
                } else {
                    print("NULL data")
                }
                
                // TODO: Use this on main thread
                self.activityIndicatorView?.stopAnimating()
                self.activityIndicatorView?.isHidden = true
            } catch {
                print("Error: \(error)")
            }
        })
        
        task.resume()
    }
    
}
