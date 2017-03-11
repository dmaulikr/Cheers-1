//
//  FluidViewController.swift
//  Cheers
//
//  Created by Minna Xiao on 3/10/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

import UIKit
import BAFluidView
import CoreMotion

class FluidViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet var swipeUpGesture: UISwipeGestureRecognizer!
    
    @IBOutlet var swipeDownGesture: UISwipeGestureRecognizer!
    
    
    // MARK: - Properties
    var fluidView: BAFluidView?
    //let numberView = NumberMorphView()
    let motionManager = CMMotionManager()
    
    var level = 0.0 //fluid level
    var alcColors: [UIColor] = []
    var alcIndex = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        startFluidAnimation()
        loadDrinkOptions()
    }
    
    @IBAction func swipeToAddDrink(_ sender: UISwipeGestureRecognizer) {
        level += 0.1 //incrementing by 10% right now
        fluidView?.fill(to: level as NSNumber!)
        alcIndex += 1
        alcIndex = alcIndex % alcColors.count
        fluidView?.fillColor = alcColors[alcIndex]
    }
    
    @IBAction func swipeToMinusDrink(_ sender: UISwipeGestureRecognizer) {
        level -= 0.1
        fluidView?.fill(to: level as NSNumber!)
    }
    
    func loadDrinkOptions() {
        let wineColor = UIColor(hex: "9B2942")
        let cocktailColor = UIColor(hex: "EB7992")
        let beerColor = UIColor(hex: "BAE278")
        let shotColor = UIColor(hex: "BE823A")
        alcColors = [wineColor, cocktailColor, beerColor, shotColor]
        
    }
    
    
    func startFluidAnimation() {
        // set up accelerometer
        if motionManager.isDeviceMotionAvailable {
            motionManager.startAccelerometerUpdates()
            motionManager.accelerometerUpdateInterval = 0.1
            print ("motion")
            motionManager.startDeviceMotionUpdates(to: OperationQueue.main, withHandler: { [weak self] (data: CMDeviceMotion?, error: Error?) in
                let nc = NotificationCenter.default
                nc.post(name: Notification.Name(kBAFluidViewCMMotionUpdate), object: self, userInfo: ["data":data!])
            })
        }
        
        // set up fluid view
        fluidView = BAFluidView(frame: self.view.frame, startElevation: level as NSNumber!)
        fluidView?.strokeColor = UIColor.white
        fluidView?.fillColor = UIColor(hex: "99d6ea")
        fluidView?.keepStationary()
        fluidView?.startAnimation()
        fluidView?.startTiltAnimation()
        
        self.view.insertSubview(fluidView!, at: 1)
        
        // doesn't seem necessary
        /*
        UIView.animate(withDuration: 0.5, animations: {
            self.fluidView?.alpha = 1.0
        }) { (_) in
            self.view.sendSubview(toBack: self.fluidView!)
        }*/
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
