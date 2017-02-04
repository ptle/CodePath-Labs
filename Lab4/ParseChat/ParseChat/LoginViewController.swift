//
//  LoginViewController.swift
//  ParseChat
//
//  Created by Peter Le on 1/31/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    var alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func login(_ sender: Any) {
        let emailtext = email.text!
        let passwordtext = password.text!
        print(emailtext)
        print(passwordtext)
        if emailtext == "" || passwordtext == ""
        {
            let alertController = UIAlertController(title: "Error", message: "Make sure email and password are filled out", preferredStyle: .alert)
            
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            
            present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        }
        else
        {
            PFUser.logInWithUsername(inBackground: emailtext, password: passwordtext) { (user: PFUser?, error: Error?) in
                if user != nil {
                    print("Success! You are now logged in! 👍")
                } else {
                    print(error?.localizedDescription ?? "unknown error occured! 😬")
                    
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription ?? "unknown error occured! 😬", preferredStyle: .alert)
                    
                    // create an OK action
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        // handle response here.
                    }
                    // add the OK action to the alert controller
                    alertController.addAction(OKAction)
                    
                    self.present(alertController, animated: true) {
                        // optional code for what happens after the alert controller has finished presenting
                    }
                }
            }
        }
    }

    @IBAction func signup(_ sender: Any) {
        let emailtext = email.text!
        let passwordtext = password.text!
        if emailtext == "" || passwordtext == ""
        {
            let alertController = UIAlertController(title: "Error", message: "Make sure email and password are filled out", preferredStyle: .alert)
            
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            
            present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        }
        else
        {
            let user = PFUser()
            user.username = emailtext
            user.password = passwordtext
            //user.email = emailtext
            
            user.signUpInBackground() {
                (succeeded: Bool?, error: Error?) -> Void in
                if let error = error {
                    //let errorString = error.userInfo["error"] as? NSString
                    // Show the errorString somewhere and let the user try again.
                    let alertController = UIAlertController(title: "Error", message: error.localizedDescription ?? "unknown error occured! 😬", preferredStyle: .alert)
                    
                    // create an OK action
                    let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                        // handle response here.
                    }
                    // add the OK action to the alert controller
                    alertController.addAction(OKAction)
                    
                    self.present(alertController, animated: true) {
                        // optional code for what happens after the alert controller has finished presenting
                    }
                    
                } else {
                    // Hooray! Let them use the app now.
                }
            }
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
