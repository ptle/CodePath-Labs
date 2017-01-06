//
//  DetailViewController.swift
//  Tumblr
//
//  Created by Jacob Smith on 1/5/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var index: Int!
    
    @IBOutlet weak var detailabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailabel.text = ("You tapped the cell at index \(index!)")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
