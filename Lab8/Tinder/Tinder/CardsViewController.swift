//
//  CardsViewController.swift
//  Tinder
//
//  Created by Peter Le on 4/4/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit

class CardsViewController: UIViewController {

    var cardInitialCenter: CGPoint!
    
    @IBOutlet weak var userImageView: UIImageView!
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        userImageView.image = UIImage(named: "ryan")
        userImageView.layer.cornerRadius = 5
        userImageView.clipsToBounds = true
        userImageView.isUserInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDrag(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        let userTouched = sender.location(in: userImageView)
        if sender.state == .began {
            cardInitialCenter = userImageView.center
        }
        else if sender.state == .changed {
            userImageView.center = CGPoint(x: cardInitialCenter.x + translation.x, y: cardInitialCenter.y)
            
            
                if(userTouched.y < cardInitialCenter.y)
                {
                    userImageView.transform = userImageView.transform.rotated(by: CGFloat((Double (translation.x/36) * Double.pi / 360)))
                }
                else
                {
                    userImageView.transform = userImageView.transform.rotated(by: CGFloat((Double (-translation.x/36) * Double.pi / 360)))
                }
            
        }
        else if sender.state == .ended {
            if(abs(translation.x) > 50)
            {
                userImageView.alpha = 0
                userImageView.center = cardInitialCenter
                userImageView.transform = CGAffineTransform.identity
                
                UIView.animate(withDuration: 0, delay: 2.0, animations: {
                    self.userImageView.alpha = 1
                }, completion: nil)
            }
            else
            {
                userImageView.center = cardInitialCenter
                userImageView.transform = CGAffineTransform.identity
            }
            
        }
    }

    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        self.performSegue(withIdentifier: "profileSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profileSegue"
        {
            let profileViewController = segue.destination as! ProfileViewController
            profileViewController.image = userImageView.image
        }
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
