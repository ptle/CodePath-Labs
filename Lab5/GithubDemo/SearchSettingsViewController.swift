//
//  SearchSettingsViewController.swift
//  GithubDemo
//
//  Created by Peter Le on 3/2/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class SearchSettingsViewController: UIViewController {

    weak var delegate: SettingsPresentingViewControllerDelegate?
    var settings = GithubRepoSearchSettings()
    
    
    @IBOutlet weak var starSlider: UISlider!
    @IBOutlet weak var starCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        starSlider.value = Float(settings.minStars)
        starCount.text = "\(Int(starSlider.value))"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.delegate?.didCancelSettings()
    }
    
    @IBAction func save(_ sender: Any) {
        self.delegate?.didSaveSettings(settings: settings)
    }

    @IBAction func sliderChanged(_ sender: Any) {
        starCount.text = "\(Int(starSlider.value))"
        settings.minStars = Int(starSlider.value)
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
