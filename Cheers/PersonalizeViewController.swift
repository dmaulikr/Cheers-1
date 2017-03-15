//
//  PersonalizeViewController.swift
//  Cheers
//
//  Created by Minna Xiao on 3/13/17.
//  Copyright © 2017 Stanford. All rights reserved.
//

import UIKit
import CircularSlider

class PersonalizeViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet weak var goOutButton: UIButton!
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var circularSlider: CircularSlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.headerView.layer.borderWidth = 1.0
        self.headerView.layer.borderColor = UIColor.black.cgColor
        
        self.circularSlider.textfield.isUserInteractionEnabled = false
        
        self.circularSlider.centeredView.layer.borderWidth = 0.0
        self.circularSlider.centeredView.layer.borderColor = UIColor.white.cgColor
        
    }
    
    // MARK: - Properties
    var drinkLimit: Int = 0

    @IBAction func goingOut(_ sender: UIButton) {
        saveDrinkLimit()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let left = storyboard.instantiateViewController(withIdentifier: "left")
        let middle = storyboard.instantiateViewController(withIdentifier: "middle")
        let right = storyboard.instantiateViewController(withIdentifier: "right")
        let top = storyboard.instantiateViewController(withIdentifier: "top")
        // let bottom
        let snapContainer = SnapContainerViewController.containerViewWith(left, middleVC: middle, rightVC: right, topVC: top, bottomVC: nil)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = snapContainer
        appDelegate.window?.makeKeyAndVisible()
        
    }
    
    private func saveDrinkLimit() {
        self.drinkLimit = Int(self.circularSlider.value)
        UserInfo.drinkLimit = self.drinkLimit
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
