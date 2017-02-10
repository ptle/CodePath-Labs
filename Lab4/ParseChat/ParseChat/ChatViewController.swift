//
//  ChatViewController.swift
//  ParseChat
//
//  Created by Peter Le on 2/7/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController,
                          UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var messagetext: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var data: [PFObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: "onTimer", userInfo: nil, repeats: true)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func send(_ sender: Any) {
        var message = PFObject(className:"Message")
        message["text"] = messagetext.text!
        message["user"] = PFUser.current()
        message.saveInBackground(){
            (succeeded: Bool?, error: Error?) -> Void in
            if let error = error {
            }
            else
            {
                print("Message was saved")
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data != nil
        {
            return data!.count
        }
        else
        {
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageTableViewCell", for: indexPath) as! messageTableViewCell
        let object = data[indexPath.row]
        let message = object["text"] as! String?
        if let user = object["user"] as! PFUser?
        {
            cell.message.text = "\(user.username!): \(message!)"
        }
        else
        {
            cell.message.text = "\(message!)"
        }
        
        return cell
    }
    
    func onTimer() {
        // Add code to be run periodically
        var query = PFQuery(className:"Message")
        
        // Retrieve the most recent ones
        query.order(byDescending: "createdAt")
        
        // Include the post data with each comment
        query.includeKey("text")
        query.includeKey("user")
        
        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) in
            if error == nil {
                // The find succeeded.
                //print("Successfully retrieved \(objects!.count) scores.")
                // Do something with the found objects
                if let objects = objects {
                    self.data = objects
                }
            } else {
                // Log details of the failure
                print("Error: \(error!)")
            }
        }
        tableView.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
