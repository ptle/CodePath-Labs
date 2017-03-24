//
//  CanvasViewController.swift
//  Lab6
//
//  Created by Peter Le on 3/23/17.
//  Copyright © 2017 CodePath. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController, UIGestureRecognizerDelegate {

    var trayOriginalCenter: CGPoint!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    
    @IBOutlet weak var arrowView: UIImageView!
    @IBOutlet weak var trayView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        trayDownOffset = 240
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didPanTry(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            trayOriginalCenter = trayView.center
        } else if sender.state == .changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        } else if sender.state == .ended {
            var velocity = sender.velocity(in: view)
            
            if(velocity.y >= 0)
            {
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.trayView.center = self.trayDown
                }, completion: nil)
                arrowView.transform = CGAffineTransform(rotationAngle: CGFloat(180 * M_PI / 180))
            }
            else if(velocity.y < 0){
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.trayView.center = self.trayUp
                }, completion: nil)
                
                arrowView.transform = CGAffineTransform(rotationAngle: CGFloat(-1 * M_PI / 180))
            }
        }
    }
    
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if sender.state == .began {
            
            var imageView = sender.view as! UIImageView
            imageView.isUserInteractionEnabled = true
            
            newlyCreatedFace = UIImageView(image: imageView.image)
            let gestureRecognizer = UIPanGestureRecognizer(target:self, action: #selector(CanvasViewController.didChangeFace(_:)))
            gestureRecognizer.delegate = self
            newlyCreatedFace.addGestureRecognizer(gestureRecognizer)
            newlyCreatedFace.isUserInteractionEnabled = true
            view.addSubview(newlyCreatedFace)
            
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            
            
            UIView.animate(withDuration:0.4, animations: {
               self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            })
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        } else if sender.state == .ended {
            UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                           animations: { () -> Void in
                            self.newlyCreatedFace.transform = self.newlyCreatedFace.transform.scaledBy(x: 0.5, y: 0.5)
            }, completion: nil)
        }
        
    }
    
    func didChangeFace(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        if sender.state == .began {

            
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            UIView.animate(withDuration:0.4, animations: {
                self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            })
        } else if sender.state == .changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        } else if sender.state == .ended {
            UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                           animations: { () -> Void in
                            self.newlyCreatedFace.transform = self.newlyCreatedFace.transform.scaledBy(x: 0.5, y: 0.5)
            }, completion: nil)
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
